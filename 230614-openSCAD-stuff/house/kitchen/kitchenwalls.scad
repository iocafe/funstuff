use <../doors/arcdoorhole.scad> 
use <../windows/slidingwindow.scad>

module kitchenwalls(width=800, length=800, front_wall_len = 800, back_wall_len = 500, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0, paint_the_room = [0.9, 0.3,0.9],
    window_y = 90, window_w = 70+5.3, window_h = 120+5.3)
{
    // Door opening size. Then we need some extra space for the door frame.
    door_width = 370;
    door_height = 253;
    
    // Position the door so that bottom of opening is 5 cm above floor level
    door_y_pos = (wall_height-door_height)/2 - 5;
        
    // Position the door horizontally off the center.
    door_x_pos = width/5.7;

    arc_window_width = door_width;
    arc_window_height = 153;
    arc_window_x_pos = width/4.7;
    
    window_1_x_pos = -140;
    window_2_x_pos = -305;
    window_3_x_pos = -240;
    window_4_x_pos = -5;
    
    // Rise the part of floor which should stay dry by 2.5 cm.
    rise_floor = 2.5;
    rised_width = width/2;
    
    // Rise walk in floor more to allow sitting to toilet seat with dry feet by 2.0 cm for 100 cm
    double_rise_floor = 2.0;
    double_rised_length = 100;
    
    // Hole size, 8 cm
    hole_size = 8;

    difference() {
        union() {
            translate([(length - back_wall_len)/2,
                -width/2+wall_thickness/2,
                wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([back_wall_len, wall_thickness, wall_height],center=true);
            
            translate([(length - back_wall_len)/2,
                -width/2 + wall_thickness, 
                wall_height/2]) 
            color(paint_the_room,wall_alpha) 
            cube([back_wall_len, 0.1, wall_height],center=true);
        }

        /* Window 4 hole */
        translate([window_4_x_pos, 
            -width/2 + wall_thickness/2, 
            window_y + window_h/2]) 
        cube([window_w, wall_thickness+1,   
            window_h],center=true);
    } 

    /* Window 4 */
    translate([window_4_x_pos, 
        - width/2 + wall_thickness/2,
        window_y + window_h/2]) 
    slidingwindow(window_w, window_h, wall_thickness); 
    
    difference() {
        union() {
            translate([(length-front_wall_len)/2,
                width/2 - wall_thickness/2, 
                wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([front_wall_len,  wall_thickness, wall_height],center=true);
            
            translate([(length-front_wall_len)/2,
                width/2 - wall_thickness, wall_height/2]) 
            color(paint_the_room,wall_alpha) 
            cube([front_wall_len, 0.1, wall_height],center=true);
        }

        // Arc door hole 
        translate([door_x_pos,
            width/2 - wall_thickness/2, 0.2]) 
        arcdoorhole(door_width, door_height, wall_thickness, wall_color,wall_alpha);
        
        /* Window 1 hole */
        translate([window_1_x_pos, width/2 - wall_thickness/2,
            window_y + window_h/2]) 
        cube([window_w, wall_thickness+1, 
            window_h],center=true);
        
        /* Window 2 hole */
        translate([window_2_x_pos, width/2 - wall_thickness/2,
            window_y + window_h/2]) 
        cube([window_w, wall_thickness+1, 
            window_h],center=true);
        
    }
    
    /* Window 1 */
    translate([window_1_x_pos, width/2 - wall_thickness/2,
        window_y + window_h/2]) 
    slidingwindow(window_w, window_h, wall_thickness); 
    
    /* Window 2 */
    translate([window_2_x_pos, width/2 - wall_thickness/2,
        window_y + window_h/2]) 
    slidingwindow(window_w, window_h, wall_thickness); 
    
    difference() {
        union() {
            // The wall downhill
            translate([length/2-wall_thickness/2, 0, wall_height/2])
            color(wall_color,wall_alpha) 
            cube([wall_thickness, width, wall_height],center=true);
            
            // Paint it
            translate([length/2-wall_thickness, 0, wall_height/2]) 
            color(paint_the_room,wall_alpha) 
            cube([0.1, width, wall_height],center=true);
        }
        
        // Arc window
        translate([length/2-wall_thickness/2, 
            arc_window_x_pos, door_height - arc_window_height])
        rotate([0,0,90])
        arcdoorhole(arc_window_width, arc_window_height, wall_thickness, wall_color,wall_alpha);
        
        /* Window 3 hole */
        translate([length/2-wall_thickness/2, 
            window_3_x_pos, 
            window_y + window_h/2]) 
        cube([wall_thickness+1, window_w,  
            window_h],center=true);
        
    }

    /* Window 3 */
    translate([length/2-wall_thickness/2,
        window_3_x_pos,
        window_y + window_h/2])
    rotate([0,0,90])
    slidingwindow(window_w, window_h, wall_thickness); 
      
}

// For testing
kitchenwalls();