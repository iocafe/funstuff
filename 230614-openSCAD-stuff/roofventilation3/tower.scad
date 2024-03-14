use <wall.scad>
use <roof.scad>
use <corner.scad>

module tower(height=100, wall_thickness=10) 
{
    window_height = 50;
    window_top = 15;
    front_window_width = 120;
    side_window_width = 80;
    
    window_frame_thickness=wall_thickness;
    playwood_thickness = 1.5;
    roof_angle = 25;
    
    translate([0,0,height/2+30]) roof(350, 50);
    
    
    corner_diam = 40;
    corner_height = height + corner_diam*tan(roof_angle)/2;
    
    translate([side_window_width/2+corner_diam,front_window_width/2,0]) 
    rotate([0,0,90])
    corner(corner_diam, corner_height, playwood_thickness, roof_angle); 

    translate([side_window_width/2+corner_diam,-front_window_width/2-corner_diam,0]) 
    rotate([0,0,90])
    corner(corner_diam, corner_height, playwood_thickness, roof_angle); 
    
    translate([-side_window_width/2-corner_diam,front_window_width/2+corner_diam,0]) 
    rotate([0,0,270])
    corner(corner_diam, corner_height, playwood_thickness, roof_angle); 

    translate([-side_window_width/2-corner_diam,-front_window_width/2,0]) 
    rotate([0,0,270])
    corner(corner_diam, corner_height, playwood_thickness, roof_angle); 

    translate([0, (front_window_width)/2+window_frame_thickness, 0]) 
    rotate([0,0,180])
    wall(height,side_window_width, window_height, window_top, window_frame_thickness,   playwood_thickness, roof_angle);


    translate([0, -(front_window_width)/2+-window_frame_thickness, 0]) 
    rotate([0,0,0])
    wall(height,side_window_width, window_height, window_top, window_frame_thickness,   playwood_thickness, roof_angle);
    
    translate([(side_window_width)/2+window_frame_thickness, 0, 0]) 
    rotate([0,0,90])
    wall(height,front_window_width, window_height, window_top, window_frame_thickness,   playwood_thickness, 0);
    
    translate([-(side_window_width)/2-window_frame_thickness, 0, 0]) 
    rotate([0,0,270])
    wall(height,front_window_width, window_height, window_top, window_frame_thickness,   playwood_thickness, 0);
}


tower();