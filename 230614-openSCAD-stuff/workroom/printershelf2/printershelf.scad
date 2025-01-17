use <../anglebarframe.scad>
use <../simpleplaywood.scad>
use <tableleg.scad>
use <printershelfdrawer.scad>

playwood_thickness = 2 * 0.75 * 2.54;
bar_diam = 3.9;

c = [0.3,0.3,0.39, 1.0];
c2 = [0.3,0.30,0.50, 1.0];
   
plywood_c = [0.80,0.43,0.32, 0.7];

module printershelf(width = 145, depth = 45, height = 77.8, explode=false)
{
    anglebar_thickness = 0.3;
    playwood_allowance = 0.1 + anglebar_thickness; // Needs to include 0.3 mm for angle bar
 
    translate([depth,0,height-playwood_thickness])
    rotate([0,180,0])
    {
    anglebarframe(depth, width, explode, c, c2);
    
    translate([-playwood_allowance,-playwood_allowance,-anglebar_thickness])
    simpleplaywood(depth, width, playwood_allowance, playwood_thickness,plywood_c);
    }
    
    text_size = 4;
    row_step = 7;
    ystart = width - row_step;
    
    color([0.9,0.9,0.1,1.0])
    {
        t1 = "WORK TABLE"; 
        t2 = str(width, "cm x ", depth, "cm");
        t3 = "plywood size";
        t4 = str(width-2*playwood_allowance, " x ", depth-2*playwood_allowance);
     
        translate([depth/2,ystart,height]) 
        {
            text(t1, size = text_size, 
                halign = "center",valign = "top");
            translate([0, -8, 0]) 
                text(t2, size = text_size, 
                    halign = "center",valign = "top");
            translate([0, -width/2, 0]) 
                text(t3, size = text_size, 
                    halign = "center",valign = "top");
            translate([0, -width/2-8, 0]) 
                text(t4, size = text_size, 
                    halign = "center",valign = "top");
        }
    } 
    
    tableleg(height-playwood_thickness, depth, bar_diam, true, explode, c, c2);
    
    translate([0, width, 0])
    mirror([0,1,0])
    tableleg(height-playwood_thickness, depth, bar_diam, false, explode, c, c2);
    
    space_for_vacuum_cleaner = 10;
    translate([0, bar_diam, space_for_vacuum_cleaner])
    rotate([90,0,90])
    tl_anglebar(width-2*bar_diam, bar_diam, c, straight1=true, straight2=true); 

    translate([depth, bar_diam, space_for_vacuum_cleaner])
    rotate([0,0,90])
    tl_anglebar(width-2*bar_diam, bar_diam, c, straight1=true, straight2=true); 
    
    translate([-playwood_allowance,-playwood_allowance+bar_diam,anglebar_thickness+space_for_vacuum_cleaner+bar_diam])
    simpleplaywood(depth, width-2*bar_diam, playwood_allowance, playwood_thickness);
    
    color([0.9,0.9,0.1,1.0])
    {
        t3 = "plywood size";
        t4 = str(width-2*bar_diam-2*playwood_allowance, " x ", depth-2*playwood_allowance);
     
        translate([depth/2,ystart,anglebar_thickness+space_for_vacuum_cleaner+bar_diam]) 
        {
            translate([0, -width/2, 0]) 
                text(t3, size = text_size, 
                    halign = "center",valign = "top");
            translate([0, -width/2-8, 0]) 
                text(t4, size = text_size, 
                    halign = "center",valign = "top");
        }
    } 

    /* d = width/3;
    l = 1.41 * d;
    translate([0, width-d-bar_diam, height-bar_diam])
    rotate([90,45,90])
    tl_anglebar(l, bar_diam, c);
    
    translate([0, d+bar_diam, height-bar_diam])
    mirror([0,1,0])
    rotate([90,45,90])
    tl_anglebar(l, bar_diam, c); */
    
    translate([depth/2+6, width/2, height-bar_diam-5.5])
    printershelfdrawer(open);
}        

printershelf();