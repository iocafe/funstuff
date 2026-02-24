w = 20;
wt = 8 + 1*sin(17*$t*360 + 60);
wd = 20 + 10*sin($t*360);
wy=w/2+wt/2+0.1;
 
 color  ("pink")  {
 cube ([67,w,10],center=true);
 translate([0,0,5])
    cube([30,w,10],center=true);
 
translate([20,wy,-5])rotate([90,0,0])
 cylinder(h=wt, d=wd,center=true);
  translate([-20,wy,-5])rotate([90,0,0])
 cylinder(h=wt, d=wd,center=true);
 translate([20,-wy,-5])rotate([90,0,0])
 cylinder(h=wt, d=wd,center=true);
 translate([-20,-wy,-5])rotate([90,0,0])
 cylinder(h=wt, d=wd,center=true);
 }     