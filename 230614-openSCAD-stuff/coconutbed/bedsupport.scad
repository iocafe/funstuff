use <bedleg.scad> 
use <hdim.scad> 
extra_leg_spacing = 1.5;
bighole_diam = 6.0;
bighole_spacing = 0.3;

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
                translate([0,mattress_width/2 - cw_w 
                    - bighole_diam/2 + bighole_spacing,0])
                rotate([0,0,0]) 
                cylinder(h=cw_w+0.2,r=bighole_diam/2,center = true);
                
                translate([0,-mattress_width/2 + cw_w 
                    + bighole_diam/2+bighole_spacing,0])
                rotate([0,0,0]) 
                cylinder(h=cw_w+0.2,r=bighole_diam/2,center = true);
            }
        }
    
        /*translate([0,0,cw_w/2]) 
            rotate([0,0,90])
            color([1,1,1])
            text(str(mattress_width," cm"), size = 7, halign = "center",valign = "center");*/
        
        if (bighole)
        {
            translate([0,0, cw_w/2]) rotate([0,0,90])
            hdim(mattress_width/2 - cw_w - bighole_diam/2 + bighole_spacing, 
                mattress_width/2, 0);
        }
        
        translate([0,0, cw_w/2]) rotate([0,0,90])
            hdim(-mattress_width/2, 
                mattress_width/2, 0, 14);
    }
}

bedsupport();