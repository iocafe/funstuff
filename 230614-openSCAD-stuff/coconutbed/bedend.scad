use <bedleg.scad> 
use <hdim.scad> 
extra_leg_spacing = 1.5;
bighole_diam = 5.0;
bighole_spacing = 0.3;
bighole_pos_coeff = 1.40; 
leglength=28;

module bedend(mattress_width = 152.4, cw_w = 5.08, cw_h = 15.24, jw_w=4.80, jw_h = 4.8, groove_depth = 1.5) 
{
    translate([cw_w/2,0,0])
        color([0.71,0.40,0.11])
        difference() 
    {
        cube([cw_w, mattress_width, cw_h],center=true);
        
        translate([0,mattress_width/2 - bighole_pos_coeff * cw_w - bighole_diam/2+bighole_spacing,0])
        rotate([0,90,0]) 
        cylinder(h=cw_w+0.2,r=bighole_diam/2,center = true, $fn = 16);

        translate([0,-mattress_width/2 + bighole_pos_coeff * cw_w + bighole_diam/2 - bighole_spacing,0])
        rotate([0,90,0]) 
        cylinder(h=cw_w+0.2,r=bighole_diam/2,center = true, $fn = 16);
    }
    
    translate([-cw_w-cw_h, 
        mattress_width/2, 
        -cw_h/2+jw_h-groove_depth+cw_w-leglength/2]) 
    rotate([90,-90,180]) 
    hdim(-leglength/2, leglength/2, jw_h/100, 3);
   
    translate([cw_w,0,0]) rotate([90,0,90])
        hdim(-mattress_width/2, mattress_width/2, 0, 16);

    translate([cw_w,0,0]) rotate([90,0,90])
        hdim(-mattress_width/2, -mattress_width/2 + bighole_pos_coeff * cw_w + bighole_diam/2 - bighole_spacing, 0, 4);
    
    w = mattress_width-2*cw_h-2*extra_leg_spacing;
    translate([-jw_w/2,0,-cw_h/2-jw_h/2+jw_h-groove_depth+cw_w]) 
        cube([jw_w, w, jw_h],center=true);
    
    translate([-jw_w,0,0]) rotate([90,0,90])
        hdim(-w/2, w/2, 0, 9);
    
    translate([0,mattress_width/2,-cw_h/2+jw_h-groove_depth+cw_w]) 
        rotate([0,0,180]) 
        bedleg(cw_w, cw_h, false, leglength);

    translate([0,-mattress_width/2,-cw_h/2+jw_h-groove_depth+cw_w]) 
        bedleg(cw_w, cw_h, true, leglength);
        
    translate([cw_w/2,-mattress_width/3, 0]) 
    rotate([90,-90,180]) 
    hdim(-cw_h/2, -cw_h/2+jw_h-groove_depth+cw_w, jw_h/100, 14);
}

bedend();