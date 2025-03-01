small_bar_d = 0.8;
separator_bar_w = 1.7;
separator_bar_d = 6.3;

glass_frame_w = 2.1;
glass_frame_hor_bar_w = 2.3;
glass_frame_t = 0.12;
glass_frame_d = 2.5;
glass_frame_flap_w = 1.9;

nro_vertical_squares = 4;

allowance = 0.3;
window_frame_color1 = [0.4, 0.2, 0.2, 1.0];
window_frame_color2 = [0.5, 0.3, 0.3, 1.0];
window_frame_color3 = [0.3, 0.4, 0.3, 1.0];

module window(width=70, height=110, nro_openings = 2, wall_thickness=15) 
{
    fixedgrid(width, height, nro_openings); 
    
    // windowhatch(width, height); 
}

module fixedgrid(width, height, nro_openings) 
{
    step_x = (width+2*separator_bar_w) / nro_openings;
    for (i = [nro_openings/-2+1:nro_openings/2-1])
    {
        x = step_x * i;
        echo(x, step_x);
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

module windowhatch(width=70, height=110) 
{
    color("red")
    //color(window_frame_color3)
    translate([0, (glass_frame_d-glass_frame_t), 0])
    genericframe(width, height, glass_frame_w, glass_frame_t);
    
    color(window_frame_color2)
    translate([0, (glass_frame_d-glass_frame_t)/2, 0])
    genericframe(width, height, glass_frame_t, glass_frame_d);

    color("blue")
    //color(window_frame_color2)
    translate([0, glass_frame_t/-2, 0])
    genericframe(width+2*glass_frame_flap_w, height+2*glass_frame_flap_w, glass_frame_flap_w, glass_frame_t);
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
window();