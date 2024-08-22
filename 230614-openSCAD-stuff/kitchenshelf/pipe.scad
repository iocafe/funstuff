use <hdim.scad>

module pipe(pipe_length = 85, pipe_diam=3.3, pipe_hole_pos=[10,20], n_holes = 2, show_dims=true)
{
    bolt_hole_diam = 0.8;
    
    difference()
    {
        translate([0, 0, pipe_length/2])
        color([0.23,0.12,0.10, 1.0])
        cylinder(h=pipe_length,r=pipe_diam/2,center = true, $fn = 16);

        for (x = [0: n_holes-1]) {
            translate([0,0,pipe_hole_pos[x]])
            rotate([90,0,0])
            cylinder(h=pipe_diam+1.0,r=bolt_hole_diam/2,center = true, $fn = 16);
        }
    }
    
    if (show_dims)
    {
        rotate([0,90,0])
        hdim(-pipe_length, 0, -2, 22);

        for (x = [0: n_holes-1]) {
            //translate([0,0,pipe_hole_pos[x]])
            rotate([0,-90,n_holes==4?-90:90])
            hdim(0, pipe_hole_pos[x], 0, x*5 + 7);
        }
    }
}   

pipe();