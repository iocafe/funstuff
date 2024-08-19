module waterdispenser()
{
    holder_diam = 28;
    holder_h = 24;
    bottle_diam = 25;
    bottle_h = 38;
    
    // translate([0, 0, pipe_length/2])
    color([0.9,0.9,0.9, 1.0])
    cylinder(h=holder_h,d=holder_diam, $fn = 22);

    color([0.23,0.12,0.90, 0.7])
    cylinder(h=holder_h+bottle_h,d=bottle_diam, $fn = 22);
}   

waterdispenser();