use <../anglebarframe.scad>
use <../simpleplaywood.scad>
use <tableleg.scad>

playwood_thickness = 2 * 0.75 * 2.54;
bar_diam = 3.9;

module worktable(width = 129, depth = 56, height = 77.8, explode=false)
{
    anglebar_thickness = 0.3;
    playwood_allowance = 0.1 + anglebar_thickness; // Needs to include 0.3 mm for angle bar
 
    translate([depth,0,height-playwood_thickness])
    rotate([0,180,0])
    {
    anglebarframe(depth, width, explode);
    
    translate([-playwood_allowance,-playwood_allowance,-anglebar_thickness])
    simpleplaywood(depth, width, playwood_allowance, playwood_thickness);
    }
    
    text_size = 4;
    row_step = 7;
    ystart = width - row_step;
    
    color([0.9,0.9,0.1,1.0])
    {
        t1 = "WORK TABLE"; 
        t2 = str(width, "cm x ", depth, "cm");
     
        translate([depth/2,ystart,height]) 
        {
            text(t1, size = text_size, 
                halign = "center",valign = "top");
            translate([0, -8, 0]) 
                text(t2, size = text_size, 
                    halign = "center",valign = "top");
        }
    } 
    
    tableleg(height-playwood_thickness, depth, bar_diam, true, explode);
    
    translate([0, width, 0])
    mirror([0,1,0])
    tableleg(height-playwood_thickness, depth, bar_diam, false, explode);
    
    c = [0.7,0.30,0.39, 1.0];
    translate([0, bar_diam, 0])
    rotate([90,0,90])
    tl_anglebar(width-2*bar_diam, bar_diam, c, straight1=true, straight2=true);

    d = width/3;
    l = 1.41 * d;
    translate([0, width-d-bar_diam, height-bar_diam])
    rotate([90,45,90])
    tl_anglebar(l, bar_diam, c);
    
    translate([0, d+bar_diam, height-bar_diam])
    mirror([0,1,0])
    rotate([90,45,90])
    tl_anglebar(l, bar_diam, c);
}        

worktable();