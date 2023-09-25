use <bedleg.scad> 
extra_leg_spacing = 1.5;

module bedend(matress_width = 152.4, cw_w = 5.08, cw_h = 15.24, jw_w=4.80, jw_h = 4.8, groove_depth = 1.5) 
{
    translate([cw_w/2,0,0])
        color([0.71,0.40,0.11])
        cube([cw_w, matress_width, cw_h],center=true);
    
    translate([-jw_w/2,0,-cw_h/2-jw_h/2+jw_h-groove_depth+cw_w]) 
        cube([jw_w, matress_width-2*cw_h-2*extra_leg_spacing, jw_h],center=true);
    
    translate([0,matress_width/2,-cw_h/2+jw_h-groove_depth+cw_w]) 
        rotate([0,0,180]) 
        bedleg(cw_w, cw_h, false);

    translate([0,-matress_width/2,-cw_h/2+jw_h-groove_depth+cw_w]) 
        bedleg(cw_w, cw_h, true);
}

bedend();