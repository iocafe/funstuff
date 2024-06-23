module bedpipe(gap_washer = 1.5, fix_to_vertical_wood_l=4.5, pipe_diam=2.54)
{
    fix_to_bed_l = 12;
    pipe_length = fix_to_bed_l + gap_washer + fix_to_vertical_wood_l;
    gap_washer_d = 3.2;
    wall_thickness = 0.3;
    translate([pipe_length/2 - gap_washer - fix_to_vertical_wood_l, 0, 0])
    rotate([0,90,0])
    {
        color([0.69,0.38,0.30, 1.0])
        difference() {
            cylinder(h=pipe_length,r=pipe_diam/2,center = true, $fn = 22); 
            cylinder(h=pipe_length+0.2,r=pipe_diam/2-wall_thickness,center = true, $fn = 22);

        }
        color([0.9,0.9,0.9, 1.0])
        translate([0,0,-pipe_length/2 + gap_washer/2 + fix_to_vertical_wood_l])
        difference() {
            cylinder(h=gap_washer,r=gap_washer_d/2,center = true, $fn = 22);
            cylinder(h=gap_washer+0.2,r=pipe_diam/2+0.05,center = true, $fn = 22); 
        }
    }
}   

bedpipe();