use <../hdim.scad> 

module ceiling_corner_anglebar(length, 
    angle1 = 90,
    angle2 = 90,
    bar_diam = 1.5 * 2.54, 
    bar_t = 0.3,
    c = [0.5,0.1,0.1])
{
    color(c) 
    {
        linear_extrude(bar_t) 
        polygon(points=[[0,0],
            [tan(angle1)*bar_diam, bar_diam],
            [length-tan(angle2)*bar_diam, bar_diam],
            [length, 0], [0,0]]);
 
        cube([length, bar_t, bar_diam]);
    }

    translate([0,0,bar_diam/2]) 
    hdim(0, length, 0, 9);

}   

module ceiling_t_bar_half(length, 
    fix_diam = 1.5 * 2.54,
    fix_t = 0.4,
    bar_diam = 1.5 * 2.54, 
    bar_t = 0.3,
    c = [0.5,0.1,0.1])
{
    color(c) 
    {
        linear_extrude(bar_t) 
        polygon(points=[[fix_t, fix_t],
            [fix_t, bar_diam],
            [length-fix_t, bar_diam],
            [length-fix_t, fix_t],
            [length-fix_diam, fix_t],
            [length-fix_diam, 0],
            [fix_diam, 0],
            [fix_diam, fix_t],
            [fix_t, fix_t],
            [fix_t, bar_diam],
            [0,0]]);
 
        
        translate([fix_diam,0,0]) 
        cube([length-2*fix_diam, bar_t, bar_diam]);
    }

    translate([0,0,bar_diam/2]) 
    hdim(fix_t, length-fix_t, 0, 9);

}   

module ceiling_t_bar(length, 
    fix_diam = 1.5 * 2.54,
    fix_t = 0.4,
    bar_diam = 1.5 * 2.54, 
    bar_t = 0.3,
    c = [0.5,0.1,0.1])
{
    translate([0,bar_t/2,0])
    ceiling_t_bar_half(length, 
        fix_diam,
    fix_t,
    bar_diam, 
    bar_t,
    c);

    translate([length,-bar_t/2-0.1,0])
    rotate([0,0,180])
    ceiling_t_bar_half(length, 
        fix_diam,
    fix_t,
    bar_diam, 
    bar_t,
    c);

}

ceiling_corner_anglebar(length = 110, 
    angle1 = 45,
    angle2 = 22.5);

translate([0,50,0])
ceiling_t_bar(length = 100);