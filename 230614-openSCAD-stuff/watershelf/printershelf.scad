use <twinwood.scad>
use <twinwoodwithholes.scad> 

module watershelf(width = 290, depth = 34, height = 96, explode = false)
{
    gap = 0.3;
    wood_w = depth/2 - gap;
    wood_t = 4.5;
    
    translate([wood_w+gap/2, width/2, height-wood_t])
    rotate([0,0,90])
    twinwood(width, wood_w, wood_t, gap, 2, explode);
    
    translate([wood_w+gap/2, width, (height-3*wood_t)/2+wood_t])
    rotate([0,90,-90])
    twinwoodwithholes(height-wood_t, wood_w, wood_t, gap, 2, false, true, explode);

    translate([wood_w+gap/2, 0, (height-wood_t*3)/2+wood_t])
    rotate([0,90,90])
    twinwoodwithholes(height-wood_t, wood_w, wood_t, gap, 2, false, true, explode);


    
    translate([wood_w+gap/2, width/2, wood_t+12])
    rotate([0,0,90])
    twinwoodwithholes(width-2*wood_t, wood_w, wood_t, gap, 2, true, true, explode);
  
    

  
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
        text("watershelf SHELF", size = text_size, 
            halign = "right",valign = "top");

    } 
}        

watershelf();