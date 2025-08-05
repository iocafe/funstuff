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
    fix_diam1 = 1.5 * 2.54,
    fix_t1 = 0.4,
    fix_diam2 = 1.5 * 2.54,
    fix_t2 = 0.4,
    bar_diam = 1.5 * 2.54, 
    bar_t = 0.3,
    c = [0.5,0.1,0.1])
{
    color(c) 
    {
        linear_extrude(bar_t) 
        polygon(points=[[fix_t1, fix_t1],
            [fix_t1, bar_diam],
            [length-fix_t2, bar_diam],
            [length-fix_t2, fix_t2],
            [length-fix_diam2, fix_t2],
            [length-fix_diam2, 0],
            [fix_diam1, 0],
            [fix_diam1, fix_t1],
            [fix_t1, fix_t1],
            [fix_t1, bar_diam]]);
 
        
        translate([fix_diam1,0,0]) 
        cube([length-(fix_diam1+fix_diam2), bar_t, bar_diam]);
    }

    
}   

module ceiling_t_bar(length, 
    fix_diam1 = 1.5 * 2.54,
    fix_t1 = 0.3,
    fix_diam2 = 1.5 * 2.54,
    fix_t2 = 0.3,
    bar_diam = 1.5 * 2.54, 
    bar_t = 0.3,
    c = [0.5,0.1,0.1])
{
    translate([0,-bar_t/2-0.02,0])
    rotate([90,0,0])
    ceiling_t_bar_half(length, 
        fix_diam2, fix_t2,
        fix_diam1, fix_t1,
        bar_diam, bar_t,
        c);

    translate([length,bar_t/2+0.02,0])
    rotate([90,0,180])
    ceiling_t_bar_half(length, 
        fix_diam1, fix_t1,
        fix_diam2, fix_t2,
        bar_diam, bar_t,
        c);

//translate([0,0,bar_diam/2]) 
    hdim(fix_t1, length-fix_t2, 0, 12);
}

module ceiling_t_bar_end_circle(
    bar_diam = 1.5 * 2.54, 
    bar_t = 0.3,
    to_big = true)
{
    length = 30;
    fix_diam = to_big ? 1.5 * 2.54 : 2.54;
    fix_t = 0.3;
  
    scale(3)
    {
        intersection() {
            union() {
                translate([0,1,0])
                ceiling_t_bar_half(length, 
                    fix_diam, fix_t, 
                    fix_diam, fix_t,
                    bar_diam, bar_t, 
                    [0.5,0.7,0.1]);

                translate([0,-1,0])
                rotate([90,0,0])
                ceiling_t_bar_half(length, 
                    fix_diam, fix_t, 
                    fix_diam, fix_t,
                    bar_diam, bar_t, 
                    [0.5,0.7,0.1]);
            }

            cylinder(h = 10, r = 10, center=true);
        }
        
        difference() {
            cylinder(h = 0.1, r = 10, center=true);
            cylinder(h = 0.12, r = 9.8, center=true);
        }
        
        hdim (fix_t, fix_diam,-1.7-bar_diam, 10);
        
        translate([0,1,0])
        rotate([0,0,90])
        hdim (0, fix_t, 0.3, -10);

        translate([0,-1,0])
        rotate([0,0,90])
        hdim (-bar_diam, 0, -10.3, 10);
    }
   
    translate([-8,25,0])
    text(str(bar_diam > 3.5 ? "big" : "small", 
            " to ",
            to_big ? "big" : "small",
            " angle bar"));
}


ceiling_corner_anglebar(length = 110, 
    angle1 = 45,
    angle2 = 22.5);

translate([0,50,0])
ceiling_t_bar(length = 100);

translate([0,-50,0])
ceiling_t_bar_end_circle(
    bar_diam = 1.5 * 2.54, 
    bar_t = 0.3,
    to_big = true);
