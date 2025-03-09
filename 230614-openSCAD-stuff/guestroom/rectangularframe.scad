use <hdim.scad> 

default_bar_diam = 3.8;
default_bar_t  = 0.3;

module rectangularframe(length = 140, width = 70, 
    bar_diam = default_bar_diam, 
    bar_t = default_bar_t, 
    explode=false, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0])
{
    d = explode ? 20 : 0;
      
    rotate([0,180,0])
    {
        translate([-length/2,-d-width/2,0]) 
        
        rectangularmetal(length, bar_diam, bar_t, c2);
        if (explode) {
            hdim(-length/2, length/2, width/2+d, -9);
        }
        
        translate([length/2,width/2+d,0]) 
        rotate([0,0,180]) 
        rectangularmetal(length, bar_diam, bar_t, c1);
        
        translate([d+length/2,-width/2,0]) 
        rotate([0,0,90]) rectangularmetal(width, bar_diam, bar_t, c2);
        if (explode) {
            rotate([0,0,90]) 
            hdim(-width/2, width/2, length/2+d, -9);
        }
        
        translate([-length/2-d,width/2,0]) 
        rotate([0,0,-90])
        rectangularmetal(width, bar_diam, bar_t, c1);
    }
}        

module rectangularmetal(length, 
    bar_diam = default_bar_diam, 
    bar_t = default_bar_t,
    c = [0.5,0.28,0.19, 1.0])
{
    color(c) 
    {
        linear_extrude(bar_t) 
        polygon(points=[[0,0],
            [bar_diam, bar_diam],
            [length-bar_diam, bar_diam],
            [length, 0], [0,0]]);
    }
}   


rectangularframe(explode=true, bar_diam = 2.54, bar_t=0.3);