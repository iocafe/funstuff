use <bedleg.scad> 
use <../hdim.scad> 
extra_leg_spacing = 1.5;
bighole_diam = 5.0;
bighole_spacing = 0.3;
bighole_pos_coeff = 1.40;

module bedsupport(matress_length=190, mattress_width = 152.4, cw_w = 5.08, cw_h = 15.24, jw_w=4.80, jw_h = 4.8, groove_depth = 1.5, bighole=true) 
{
    translate([0,0,-cw_h/2+cw_w-groove_depth+cw_w/2])
    {
        difference()
        {
            color([0.71,0.40,0.11])
                cube([cw_h, mattress_width, cw_w],center=true);
            
            if (bighole)
            {
                translate([0,mattress_width/2 - bighole_pos_coeff * cw_w 
                    - bighole_diam/2 + bighole_spacing,0])
                rotate([0,0,0]) 
                cylinder(h=cw_w+0.2,r=bighole_diam/2,center = true, $fn = 16);
                
                translate([0,-mattress_width/2 + bighole_pos_coeff * cw_w 
                    + bighole_diam/2+bighole_spacing,0])
                rotate([0,0,0]) 
                cylinder(h=cw_w+0.2,r=bighole_diam/2,center = true, $fn = 16);
            }
        }
    
        color([0.8,0.8,0.5,1.0])
        {
            translate([0,0,cw_w/2]) 
            rotate([0,0,90])
            text(str(0.1 * round(10*mattress_width)), size = 6, 
                halign = "center",valign = "center"); 
            translate([0, 0,-cw_w/2]) 
            rotate([180,0,90])
            text(str(0.1 * round(10*mattress_width)), size = 6, 
                halign = "center",valign = "center");
        }
        
        if (bighole)
        {
            translate([0,0, cw_w/2]) rotate([0,0,90])
            hdim(mattress_width/2 - bighole_pos_coeff * cw_w - bighole_diam/2 + bighole_spacing, 
                mattress_width/2, 0);
        }
        
        translate([0,0, cw_w/2]) rotate([0,0,90])
            hdim(-mattress_width/2, 
                mattress_width/2, 0, 14);
    }
}

bedsupport();