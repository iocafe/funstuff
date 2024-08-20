use <hdim.scad>

module pipe(pipe_length = 85, pipe_diam=1.2, first_shelf_y = 15,shelf_y_step = 15, n_shelfs = 3)
{
    bolt_hole_diam = 0.6;
    
    difference()
    {
        translate([0, 0, pipe_length/2])
        color([0.23,0.12,0.10, 1.0])
        cylinder(h=pipe_length,r=pipe_diam/2,center = true, $fn = 16);

        for (x = [0: n_shelfs-1]) {
            translate([0,0,x * shelf_y_step + first_shelf_y])
            rotate([90,0,0])
            cylinder(h=pipe_diam+1.0,r=bolt_hole_diam/2,center = true, $fn = 16);
        }
    }
    
    rotate([0,90,0])
    hdim(-pipe_length, 0, -2, 5);
}   

pipe();