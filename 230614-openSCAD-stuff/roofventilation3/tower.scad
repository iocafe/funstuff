// use <wall.scad>
use <roof.scad>
use <longwall.scad>

module tower() 
{
    explode = false;
    window_open_angle = 92;
    
    box_height = 100;
    box_length = 140;
    box_width = 90;
    overlap = 80;
    roof_angle = 20;
    lprofile_width=2.54;
    lprofile_thickness=0.3;
    playwood_thickness = 2.54 * 0.75;
    
    /* window_height = 50;
    window_top = 15;
    front_window_width = 120;
    side_window_width = 80;
    window_frame_thickness=wall_thickness;
*/
    
    translate([0,0,30]) 
    roof(box_length, box_width, overlap, roof_angle); 
   
    translate([0,-box_width/2,0]) 
    longwall(roof_angle, box_height, box_width, 
        lprofile_width, lprofile_thickness, 
        playwood_thickness,
        window_open_angle, explode); 
/*    
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
    */
}


tower();