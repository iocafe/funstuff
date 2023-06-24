module bedroomwalls(door_x = 0, side_door=false, width=250, length=200, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0, paint_the_room = [0.0, 0.3,0.9])
{
    // Door opening size. Then we need some extra space for the door frame.
    door_width = 90+5;
    door_height = 210+2.5;
    
    // Position the door so that bottom of opening is 5 cm above floor level
    door_y_pos = (wall_height-door_height)/2 - 5;
    
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
            translate([0,-width/2+wall_thickness/2, wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([length, wall_thickness, wall_height],center=true);
            
            translate([0,-width/2+wall_thickness, wall_height/2]) 
            color(paint_the_room,wall_alpha) 
            cube([length, 0.1, wall_height],center=true);
        }
      }

    difference() {
        union() {
            translate([0,width/2-wall_thickness/2, wall_height/2]) color(wall_color,wall_alpha) cube([length,  wall_thickness, wall_height],center=true);
            translate([0,width/2-wall_thickness, wall_height/2]) color(paint_the_room,wall_alpha) cube([length,  0.1, wall_height],center=true);
        }

        /* Door  */
        if (side_door) {
            translate([door_x, width/2 - wall_thickness/2, 
                wall_height/2- door_y_pos]) 
                cube([door_width, wall_thickness+1, door_height],center=true);
        }
    }
    
    difference() {
        union() {
            translate([length/2-wall_thickness/2, 0, wall_height/2]) color(wall_color,wall_alpha) cube([wall_thickness, width, wall_height],center=true);
            translate([length/2-wall_thickness, 0, wall_height/2]) color(paint_the_room,wall_alpha) cube([0.1, width, wall_height],center=true);
        }

        /* Door */
        if (!side_door) {
            translate([length/2-wall_thickness/2, door_x, wall_height/2-door_y_pos])
                   cube([wall_thickness+1, door_width, door_height],center=true);
        }
    }     

    difference() {
        union() {
            translate([-length/2+wall_thickness/2, 0, wall_height/2]) color(wall_color,wall_alpha) cube([wall_thickness, width, wall_height],center=true);
            translate([-length/2+wall_thickness, 0, wall_height/2])  color(paint_the_room,wall_alpha) cube([0.1, width, wall_height],center=true);
        }
    }
}

/* For testing */
bedroomwalls();