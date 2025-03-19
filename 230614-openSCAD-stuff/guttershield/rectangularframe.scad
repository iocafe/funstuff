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
        //if (explode) {
            hdim(-length/2, length/2, width/2+d, -9);
        //}
        
        translate([length/2,width/2+d,0]) 
        rotate([0,0,180]) 
        rectangularmetal(length, bar_diam, bar_t, c1);
        
        translate([d+length/2,-width/2,0]) 
        rotate([0,0,90]) rectangularmetal(width, bar_diam, bar_t, c2);
        //if (explode) {
            rotate([0,0,90]) 
            hdim(-width/2, width/2, length/2+d, -9);
        //}
        
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
  line_w = 0.12;

  p=[[0,0],
      [bar_diam, bar_diam],
      [length-bar_diam, bar_diam],
      [length, 0], [0,0]];

  p2=[[line_w*2.5,line_w],
    [bar_diam+line_w*0.5, bar_diam-line_w],
    [length-bar_diam-line_w*0.5, bar_diam-line_w],
    [length-line_w*2.5, line_w], [line_w*2.5,line_w]];

  small = 0.01;

  color(c) 
  linear_extrude(bar_t) 
  polygon(p);
      
  translate([0,0,-small/2])
  color("AliceBlue") 
  linear_extrude(bar_t+small) 
  polygon(p2);
}   


rectangularframe(explode=true, bar_diam = 2.54, bar_t=0.3);