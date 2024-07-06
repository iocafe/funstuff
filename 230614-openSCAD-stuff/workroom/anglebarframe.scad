use <hdim.scad> 

bar_diam = 3.8;
bar_t  = 0.3;

module anglebarframe(length = 59, width = 210, explode=true)
{
    d = explode ? 20 : 0;
    c1 = [0.5,0.28,0.19, 1.0];
    c2 = [0.8,0.30,0.29, 1.0];
    
    rotate([0,180,0])
    {
    translate([-length,-d,0]) 
    anglebar(length, c1);
    translate([0,width+d,0]) 
    rotate([0,0,180])
    anglebar(length, c1);
    translate([d,0,0]) 
    rotate([0,0,90])
    anglebar(width, c2);
    translate([-length-d,width,0]) 
    rotate([0,0,-90])
    anglebar(width,c2);
    }
}        

module anglebar(length, c)
{
   color(c)
    {
        linear_extrude(bar_t) 
        polygon(points=[[0,0],
            [bar_diam, bar_diam],
            [length-bar_diam, bar_diam],
            [length, 0], [0,0]]);
 
        cube([length, bar_t, bar_diam]);
    }
}   


anglebarframe();