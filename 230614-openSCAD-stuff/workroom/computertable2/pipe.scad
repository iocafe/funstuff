use <hdim.scad>

module pipe(pipe_length = 85, pipe_diam=2.54, first_shelf_y = 15, second_shelf_y = 30, show_dimensions = false)
{
    bolt_hole_diam = 0.6;
    
    difference()
    {
        translate([0, 0, pipe_length/2])
        color([0.23,0.12,0.10, 1.0])
        cylinder(h=pipe_length,r=pipe_diam/2,center = true, $fn = 16);

        translate([0,0, first_shelf_y])
        rotate([90,0,0])
        cylinder(h=pipe_diam+1.0,r=bolt_hole_diam/2,center = true, $fn = 16);
        
        if (second_shelf_y > 0) {
            translate([0,0, second_shelf_y])
            rotate([90,0,0])
            cylinder(h=pipe_diam+1.0,r=bolt_hole_diam/2,center = true, $fn = 16);
        }
    }
    
    if (show_dimensions) translate([0,-5,0])
    {
        rotate([0,90,90])
        hdim(-first_shelf_y, 0, 0,5);

        if (second_shelf_y > 0) {
            rotate([0,90,-90])
            hdim(-second_shelf_y, 0, 0,5);
        }
    }
}   

pipe();