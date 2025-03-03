arc_window_w = 110;
arc_window_h = 145;
arc_window_hatches = 2;
arc_window_pos = 75;

module arc_window_hole(wall_thickness=15, window_width=arc_window_w, window_height=arc_window_h,window_pos = arc_window_pos, wall_color=[1,1,1],wall_alpha=0.3)
{
    $fn = 50;
    r = 1.4 * window_width;
    dx = window_width / 2; 
    
    translate([0, wall_thickness/2, window_pos])
    intersection() {
        color(wall_color, 1.0) 
        translate([0,0,window_height/2-0.1])
        cube([window_width, wall_thickness+1, 
            window_height],center=true);
        
        color(wall_color, 1.0)
        translate([0,0, window_height - r])
        rotate([90,0,0]) 
        cylinder(h=wall_thickness+1, r=r, center=true); 
    }
}

// For testing
arc_window_hole();