use <roofwindow.scad>
use <playwood.scad>


module wall(wall_height=100,window_width=100, window_height=60, window_top=10, window_frame_thickness=10, playwood_thickness = 1.5, roof_angle=20) 
{
    wall_width=window_width;
    frame_profile_width = 4;

/*
    color([0.5,0.5,0.5])
    translate([0, 0, 0]) 
    difference() {
        cube([wall_width,window_frame_thickness,wall_height], center=true);
    
        translate([0, 0, (wall_height-window_height)/2-window_top]) 
        cube([window_width,window_frame_thickness+0.2,window_height], center=true);
    }
*/    
    /* Left window glass frame. */
    translate([0, 0, (wall_height-window_height)/2-window_top]) 
    color([0.5,0.3,0.3])
    roofwindow(window_width, window_height, window_frame_thickness,frame_profile_width);

    translate([-wall_width/2,window_frame_thickness/2,window_height-window_top])
    rotate([0,0,270])
    playwood(wall_width, window_top, playwood_thickness, 0); 
    
    h = wall_height - window_height - window_top;
    // cut_depth = window_width * tan(roof_angle);
    translate([-wall_width/2,window_frame_thickness/2,-h/2-frame_profile_width])
    rotate([0,0,270])
    playwood(wall_width/2, h, playwood_thickness, roof_angle); 

    translate([wall_width/2,window_frame_thickness/2-playwood_thickness,-h/2-frame_profile_width])
    rotate([0,0,90])
    playwood(wall_width/2, h, playwood_thickness, roof_angle); 
}


wall();