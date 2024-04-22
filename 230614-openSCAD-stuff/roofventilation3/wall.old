use <windowpack.scad>
use <playwood.scad>


module wall(wall_height=110,window_width=80, window_height=60, window_top=10, window_frame_thickness=10, playwood_thickness = 1.5, roof_angle=20, explode=false) 
{
    open_angle = 45;
    wall_width=window_width;
    lprofile_width=2.54;
    lprofile_thickness=0.3;
    
    translate([0, 0, -window_top-window_height]) 
    color([0.5,0.3,0.3])
    windowpack(window_height, window_width,  
        lprofile_width, lprofile_thickness,
        open_angle, explode); 

    translate([-wall_width/2,playwood_thickness,0]) 
    rotate([0,0,270])
    playwood(wall_width, window_top, playwood_thickness, 0); 
    
    h = wall_height - window_height - window_top;
    translate([-wall_width/2,playwood_thickness,-window_height-window_top])
    rotate([0,0,270])
    playwood(wall_width/2, h, playwood_thickness, roof_angle); 

    translate([wall_width/2,0,-window_height-window_top])
    rotate([0,0,90])
    playwood(wall_width/2, h, playwood_thickness, roof_angle); 
}


wall();