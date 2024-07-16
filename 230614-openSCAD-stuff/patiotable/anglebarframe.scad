use <hdim.scad> 

module anglebarframe(length = 104, width = 83, bar_diam = 3.8, bar_t = 0.3, explode=false)
{
    d = explode ? 20 : 0;
    c1 = [0.5,0.28,0.19, 1.0];
    c2 = [0.8,0.30,0.29, 1.0];
    
    translate([0,-d,0]) 
    anglebar(length, c1);
    hdim(0, length, 0, 5);
    translate([length,width+d, 0]) 
    rotate([0,0,180])
    anglebar(length, c1);
    translate([length+d,0,bar_t]) 
    rotate([0,0,90])
    anglebar(width-2*bar_t, c2);
    translate([-d,width,bar_t]) 
    rotate([0,0,-90]) {
        anglebar(width-2*bar_t,c2);
        hdim(bar_t, width-bar_t, 0, 5);
        hdim(0, width, 0, 12);
    }
}        

module anglebar(length = 63, c = [0.5,0.28,0.19, 1.0], bar_diam = 3.8, bar_t = 0.3)
{
   color(c)
    {
        cube([length, bar_diam, bar_t]);
        cube([length, bar_t, bar_diam]);
    }
}   

module anglesupport(bar_diam = 2, bar_t = 0.2, show_dims = false)
{
    bar_a = 16;
    bar_b = 20;
    bar_a_len = sqrt(bar_a*bar_a + bar_a*bar_a);
    bar_b_len = sqrt(bar_b*bar_b + bar_b*bar_b);
    bar_angle = 45;
    c = [0.8,0.30,0.29, 1.0];

    translate([-1, 0, bar_a+1.7])
    rotate([0, 90 - bar_angle, 0])
    rotate([-90, 0, 0]) {
        anglebar(bar_a_len, c, bar_diam, bar_t);
        if (show_dims) hdim(0, bar_a_len, 0, 9);
    }
    
    translate([bar_t, 0, bar_b+1.7])
    rotate([0, 0, 90])
    rotate([0, 90 - bar_angle, 0])
    rotate([180, 0, 0]) {
        anglebar(bar_b_len, c, bar_diam, bar_t);
        if (show_dims) hdim(0, bar_b_len, 0, 9);
    }
}  

anglesupport();