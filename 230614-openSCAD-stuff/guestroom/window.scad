std_window_w = 70;
std_window_h = 110;
std_window_hatches = 2;
std_window_pos = 90;
std_nro_vertical_squares = 4;

wide_window_w = 140;
wide_window_h = 110;
wide_window_hatches = 4;

small_window_w = 50;
small_window_h = 50;
small_window_hatches = 2;
small_window_pos = 150;
small_nro_vertical_squares = 2;

small_bar_d = 0.8;
separator_bar_w = 1.7;
separator_bar_d = 6.3;

glass_frame_w = 2.1;
glass_divider_w = 2.3;
glass_frame_t = 0.12;
glass_frame_d = 2.5;
glass_frame_flap_w = 1.9;


allowance = 0.3;
hinge_dx = 1;
hinge_dy = 3;
window_frame_color1 = [0.4, 0.2, 0.2, 1.0];
window_frame_color2 = [0.5, 0.3, 0.3, 1.0];
window_frame_color3 = [0.3, 0.4, 0.3, 1.0];

module std_window(wall_thickness=15, open_angle=0, window_pos = std_window_pos)
{
    translate([0,0,window_pos])
    window(wall_thickness, open_angle, 
        std_window_w, std_window_h, 
        std_window_hatches, 
        std_nro_vertical_squares);
}

module std_window_hole(wall_thickness=15, window_pos = std_window_pos)
{
    translate([0,wall_thickness/2,window_pos+std_window_h/2])
    color("white")
    cube([std_window_w, wall_thickness+1.0, std_window_h],center=true);
}

module wide_window(wall_thickness=15, open_angle=0, window_pos = std_window_pos)
{
    translate([0,0,window_pos])
    window(wall_thickness, open_angle, 
        wide_window_w, wide_window_h, 
        wide_window_hatches, 
        std_nro_vertical_squares);
}

module wide_window_hole(wall_thickness=15, window_pos = std_window_pos)
{
    translate([0,wall_thickness/2,window_pos+wide_window_h/2])
    color("white")
    cube([wide_window_w, wall_thickness+1.0, wide_window_h],center=true);
}

module small_window(wall_thickness=15, open_angle=0, window_pos = small_window_pos)
{
    translate([0,0,window_pos])
    window(wall_thickness, open_angle, 
        small_window_w, small_window_h, 
        small_window_hatches, small_nro_vertical_squares);
}

module small_window_hole(wall_thickness=15, window_pos = small_window_pos)
{
    translate([0,wall_thickness/2,window_pos+small_window_h/2])
    color("white")
    cube([small_window_w, wall_thickness+1.0, small_window_h],center=true);
}

module window(wall_thickness=15, open_angle=0, width=std_window_w, height=std_window_h, nro_openings = std_window_hatches,
    nro_vertical_squares=std_nro_vertical_squares) 
{
    fixedgrid(width, height, nro_openings, nro_vertical_squares); 
    
    hatch_w = (width - (2*nro_openings-2)*separator_bar_w)/nro_openings - 2 * allowance;
    hatch_h = height - 2 * allowance; 
    step_x = (width+2*separator_bar_w) / nro_openings;
    for (i = [0:nro_openings-1])
    {
        x = step_x * (i - nro_openings/2 + 0.5);

        translate([x, 0, height/2]) 
        windowhatch(hatch_w, hatch_h, open_angle, i,
            nro_vertical_squares); 
    }
}

module fixedgrid(width, height, nro_openings, nro_vertical_squares) 
{
    step_x = (width+2*separator_bar_w) / nro_openings;
    for (i = [nro_openings/-2+1:nro_openings/2-1])
    {
        x = step_x * i;
        color(window_frame_color1) 
        translate([x - separator_bar_w/2-0.02, 
            separator_bar_d/2, height/2]) 
        cube([separator_bar_w, separator_bar_d, height],
                center=true);
            
        color(window_frame_color2) 
        translate([x + separator_bar_w/2+0.02, 
            separator_bar_d/2, height/2]) 
        cube([separator_bar_w, separator_bar_d, height],
            center=true);
   }
   
   for (i = [0:nro_openings-1])
   {
       x = step_x * (i - nro_openings/2 + 0.5);

       color(window_frame_color2) 
       translate([x, separator_bar_d/2, height/2]) 
       cube([small_bar_d, small_bar_d, height],
           center=true);
   }
   
   step_y = (height+glass_frame_w) / nro_vertical_squares;
   for (i = [nro_vertical_squares/-2+1:nro_vertical_squares/2-1])
   {
       y = step_y * i + height/2;

       color(window_frame_color1) 
       translate([0, separator_bar_d/2, y]) 
       cube([width, small_bar_d, small_bar_d],
           center=true);
   }   
}

module windowhatch(width=70, height=110, open_angle=0, step=0, nro_vertical_squares=std_nro_vertical_squares) 
{
    dx = step%2 == 0 ? width/2 + hinge_dx : -width/2 - hinge_dx;
    dy = hinge_dy;
    translate([-dx, -dy, 0])
    rotate([0,0, step%2 == 0 ? -open_angle : open_angle])
    translate([dx, dy, 0])
    {
        color(window_frame_color2)
        translate([0, (glass_frame_d-glass_frame_t), 0])
        genericframe(width, height, glass_frame_w, glass_frame_t);
        
        color(window_frame_color3)
        translate([0, (glass_frame_d-glass_frame_t)/2, 0])
        genericframe(width, height, glass_frame_t, glass_frame_d);

        color(window_frame_color2)
        translate([0, glass_frame_t/-2, 0])
        genericframe(width+2*glass_frame_flap_w, height+2*glass_frame_flap_w, glass_frame_flap_w, glass_frame_t);
        
        color(window_frame_color1) 
        translate([0, (glass_frame_d-glass_frame_t), 0])
        cube([glass_divider_w, glass_frame_t, 
            height-2*glass_frame_w], center=true);
        
        step_y = (height+glass_frame_w) / nro_vertical_squares;
        for (i = [nro_vertical_squares/-2+1:nro_vertical_squares/2-1])
        {
           y = step_y * i;

           color(window_frame_color1) 
           translate([0, (glass_frame_d-glass_frame_t), y]) 
           cube([width-2*glass_frame_w, glass_frame_t, glass_divider_w],
               center=true);
       }   
   }
} 


module genericframe(width=70, height=110, profile_width = 5, profile_depth = 8) 
{
    translate([-(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);
    
    translate([(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);

    translate([0, 0, -(height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);

    translate([0, 0, (height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);
}    

// For testing
wide_window();