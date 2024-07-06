use <../anglebarframe.scad>
use <../simpleplaywood.scad>


module worktable(width = 210, depth = 59, height = 79, explode=false)
{
    anglebar_thickness = 0.3;
    playwood_allowance = 0.3 + anglebar_thickness; // Needs to include 0.3 mm for angle bar
 
    translate([0,0,height])
    anglebarframe(depth, width, explode);
    
    translate([0,0,height-anglebar_thickness])
    simpleplaywood(depth, width, playwood_allowance);
    
    
    text_size = 5;
    row_step = 7;
    xmargin = 2;
    ystart = width - row_step;
    //color([0.8,0.8,0.8, 0.6]) 
    //cube([depth, width, height], center = false);
    
    color([0.5,0.5,0.1,1.0])
    {
        translate([xmargin,ystart,height]) 
        text("WORK TABLE", size = text_size, 
            halign = "left",valign = "top");

    } 
}        

worktable();