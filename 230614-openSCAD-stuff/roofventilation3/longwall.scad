// Log wall with window and decorative corners
use <windowpack.scad>
use <vertical2x2.scad>
use <corner.scad>

module longwall(roof_angle=20, 
    box_height=80, box_width=60, 
    lprofile_width=2.54, lprofile_thickness=0.3, 
    playwood_thickness=2.54*0.75,
    open_angle = 100, explode=false) 
{
    corner4x4size = 8.0;
    under_window_h = 10;
    over_window_h = 20;
    playwood_thickness = 2.54 * 0.75;
    corner_diam = 40;
    corner_cut_depth = 3.5;
    
    explo_dist = explode ? 14 : 0;
    window_h = box_height-under_window_h-over_window_h;
    
    translate([0,0,-window_h - over_window_h])
    windowpack(window_h, box_width-2*corner4x4size, 
        lprofile_width, lprofile_thickness,
        open_angle, explode);
    
    translate([(box_width-corner4x4size)/2,0,0])
    vertical2x2(box_height, corner4x4size, roof_angle); 

    translate([(-box_width+corner4x4size)/2,0,0])
    vertical2x2(box_height, corner4x4size, roof_angle); 
    
    translate([-box_width/2+corner_cut_depth, corner_cut_depth, 0])
    rotate([0,0,180])
    corner(corner_diam, box_height, corner_cut_depth, playwood_thickness, roof_angle); 

}        

longwall();