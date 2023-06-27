use <kitchendoor.scad> 

module kitchenwalls(width=800, length=700, front_wall_len = 600, back_wall_len = 500, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0, paint_the_room = [0.9, 0.3,0.9])
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
    } 

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
            cube([front_wall_len,  0.1, wall_height],center=true);
        }

        // Door 
        translate([door_x_pos,
            width/2 - wall_thickness/2, 0]) 
        kitchendoor(door_width, door_height, wall_thickness, wall_color,wall_alpha);
        }
    
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
        kitchendoor(arc_window_width, arc_window_height, wall_thickness, wall_color,wall_alpha);
    }     
}

// For testing
kitchenwalls();