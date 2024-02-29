use <wall.scad>
use <roof.scad>

module tower(width=180, height=100, wall_thickness=10) 
{
    window_height = 70;
    window_top = 15;
    front_window_width = 120;
    side_window_width = 80;
    
    window_frame_thickness=10;
    playwood_thickness = 1.5;
    roof_angle = 25;
    
    translate([0,0,height/2+30]) roof(350, 50);
    
    translate([0, (width-wall_thickness)/2, 0]) 
    wall(height,front_window_width, window_height, window_top, window_frame_thickness, playwood_thickness, roof_angle);
    
    /*    translate([0, -(width-wall_thickness)/2, 0]) 
    wall(width, height, wall_thickness);

    translate([-(width-wall_thickness)/2, 0, 0]) 
    rotate([0,0,90]) 
    wall(width, height, wall_thickness);

    translate([(width-wall_thickness)/2, 0, 0]) 
    rotate([0,0,90]) 
    wall(width, height, wall_thickness);
*/
}


tower();