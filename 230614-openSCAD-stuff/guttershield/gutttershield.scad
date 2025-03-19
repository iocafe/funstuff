use <anglebarframe.scad> 
use <rectangularframe.scad> 
use <hinge.scad> 
use <metals.scad> 

l = 200;
w = 30;
angle_bar_diam = 2.54;
angle_bar_t  = 0.3;
rect_bar_w = 2.50;
rect_bar_t  = 0.4;

module guttershield(explode=false)
{

  anglebarframe(l, w, angle_bar_diam, angle_bar_t,
    explode);
  
  translate([0,0,rect_bar_t + (explode ? 40 : 0)])
  rectangularframe(l, w, 
    rect_bar_w,  rect_bar_t, explode);
  
color("Red")
  translate([0,w/2,1.1])
  rotate([-90,0,0]) 
  hinge();

color("Red")
  translate([l/2-15,w/2,1.1])
  rotate([-90,0,0]) 
  hinge();

color("Red")
  translate([-l/2+15,w/2,1.1])
  rotate([-90,0,0]) 
  hinge();
  
  color("MintCream") 
  translate([0,(explode ? 60 : w/2+0.5),-angle_bar_diam])
  anglebar(l-10, "GreenYellow", angle_bar_diam, angle_bar_t-0.2);
}



guttershield(explode=true);