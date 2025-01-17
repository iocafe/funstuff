use <../twinwood.scad>
use <../twinwoodwithholes.scad>
use <../foot.scad> 

module printershelf(width = 145, depth = 34, height = 78, explode = false)
{
    gap = 0.3;
    wood_w = depth/2 - gap;
    wood_t = 4.5;
    
    translate([wood_w+gap/2, width/2, height-wood_t])
    rotate([0,0,90])
    twinwood(width, wood_w, wood_t, gap, 2, explode);
    
    translate([wood_w+gap/2, width, (height-wood_t)/2+wood_t])
    rotate([0,90,-90])
    twinwoodwithholes(height-3*wood_t, wood_w, wood_t, gap, 2, true, true, explode);

    translate([wood_w+gap/2, 0, (height-wood_t)/2+wood_t])
    rotate([0,90,90])
    twinwoodwithholes(height-3*wood_t, wood_w, wood_t, gap, 2, true, true, explode);

    translate([wood_w+gap/2, width/2, wood_t])
    rotate([0,0,90])
    twinwood(width, wood_w, wood_t, gap, 2, explode);
    
    translate([wood_w+gap/2, width/2, 2*wood_t+48])
    rotate([0,0,90])
    twinwoodwithholes(width-2*wood_t, wood_w, wood_t, gap, 2, true, true, explode);
  
    
    foot_z = explode ? -20 : 0;
    foot_start = 8;
    translate([depth/2,foot_start,wood_t])
    rotate([0,0,90])
    foot(wood_w, wood_t, gap);
    translate([depth/2,width-foot_start,wood_t])
    rotate([0,0,90])
    foot(wood_w, wood_t, gap);
  
    text_size = 5;
    row_step = 7;
    xmargin = 2;
    ystart = width - row_step;
    color([0.8,0.1, 0.1,0.1]) 
    cube([depth, width, height], center = false);
    
    color([0.7,0.7,0.7,1.0])
    {
        translate([xmargin,ystart,height]) 
        rotate([0,0,90])
        text("PRINTER SHELF", size = text_size, 
            halign = "right",valign = "top");

    } 
}        

printershelf();