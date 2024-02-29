use <roofwindow.scad>

module wall(width=140, height=120, wall_thickness=10) 
{
    pole_diam = 1.8;
    profile_depth = 1.5;
    corner_wall_width = 20;

    /* Opening size for window. */
    open_w = 80;
    open_h = 60;

    color([0.5,0.5,0.5])
    translate([0, 0, 0]) 
    difference() {
        cube([width,wall_thickness,height], center=true);
    
        cube([open_w,wall_thickness+0.2,open_h], center=true);
    }
    
    /* Left window glass frame. */
    translate([0, 0, 0]) 
    color([0.5,0.3,0.3])
    roofwindow(open_w, open_h, wall_thickness);
}


wall();