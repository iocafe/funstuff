use <../doors/basicdoor.scad>
use <../windows/slidingwindow.scad>

module bedroomwalls(door_x = 0, bedroom_nr=2, width=350, length=400, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0, paint_the_room = [0.0, 0.3,0.9],
    window_y = 90, window_w = 80+5.3, window_h = 120+5.3)
{
    // Door opening size. Then we need some extra space for the door frame.
    door_width = 90+5.3;
    door_height = 210+3.2;
    
    // Position the door vertically
    door_y_pos = (wall_height-door_height)/2+0.1;
    
    /* Window positions */
    window_1_x_pos = bedroom_nr == 1 ? 100 : 50;
    window_2_x_pos = -window_1_x_pos;
    window_3_x_pos = bedroom_nr == 1 ? 90 : 55;
    window_4_x_pos = -window_3_x_pos;
    window_5_x_pos = 100;
    
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
        
        /* Window 1 hole */
        if (bedroom_nr != 2) {
            translate([window_1_x_pos,-width/2+wall_thickness/2,
                window_y + window_h/2]) 
            cube([window_w, wall_thickness+1, 
                window_h],center=true);
        }
        
        /* Window 2 hole */
        if (bedroom_nr == 1) {
            translate([window_2_x_pos,-width/2+wall_thickness/2,
                window_y + window_h/2]) 
            cube([window_w, wall_thickness+1, 
                window_h],center=true);
        }
    }
    
    /* Window 1 */
    if (bedroom_nr != 2) {
        translate([window_1_x_pos,-width/2+wall_thickness/2,
            window_y + window_h/2]) 
        slidingwindow(window_w, window_h, wall_thickness); 
    }
    
    /* Window 2 */
    if (bedroom_nr == 1) {
        translate([window_2_x_pos,-width/2+wall_thickness/2,
            window_y + window_h/2]) 
        slidingwindow(window_w, window_h, wall_thickness); 
    }
    
    difference() {
        union() {
            translate([0,width/2-wall_thickness/2, wall_height/2])
            color(wall_color,wall_alpha) 
            cube([length, wall_thickness, wall_height],center=true);
            
            translate([0,width/2-wall_thickness, wall_height/2])
            color(paint_the_room,wall_alpha)
            cube([length,  0.1, wall_height],center=true);
        }

        /* Door hole */
        if (bedroom_nr==3) {
            translate([door_x, width/2 - wall_thickness/2, 
                wall_height/2 - door_y_pos]) 
            cube([door_width, wall_thickness+1, door_height],
                center=true); 
        }
        
         /* Window 5 hole */
        if (bedroom_nr == 2) {
            translate([window_5_x_pos, width/2 -wall_thickness/2,
                window_y + window_h/2]) 
            cube([window_w, wall_thickness+1, 
                window_h],center=true);
        }
    }
    
    /* Window 2 */
    if (bedroom_nr == 2) {
        translate([window_5_x_pos,width/2-wall_thickness/2,
            window_y + window_h/2]) 
        slidingwindow(window_w, window_h, wall_thickness); 
    }
    
    /* Door */
    if (bedroom_nr==3) {
        translate([door_x, width/2 - wall_thickness/2, 
            wall_height/2 - door_y_pos]) 
        rotate([0,0,180])
        basicdoor(door_width, door_height, wall_thickness, true, 45);
    } 
        
    difference() {
        union() {
            translate([length/2-wall_thickness/2, 0, wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([wall_thickness, width, wall_height],center=true);
            
            translate([length/2-wall_thickness, 0, wall_height/2]) 
            color(paint_the_room,wall_alpha) 
            cube([0.1, width, wall_height],center=true);
        }

        /* Door opening */
        if (bedroom_nr<=2) {
            translate([length/2-wall_thickness/2, door_x, wall_height/2-door_y_pos])
            cube([wall_thickness+1, door_width, door_height],center=true);
        }
    }     

    /* Door */
    if (bedroom_nr<=2) {
        translate([length/2-wall_thickness/2, door_x, wall_height/2-door_y_pos])
        rotate([0,0,90])
        basicdoor(door_width, door_height, wall_thickness, true, 30);
        
    }
    difference() {
        union() {
            translate([-length/2+wall_thickness/2, 0, wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([wall_thickness, width, wall_height],center=true);
            
            translate([-length/2+wall_thickness, 0, wall_height/2])
            color(paint_the_room,wall_alpha) 
            cube([0.1, width, wall_height],center=true);
        }
        
        /* Window 3 hole */
        if (bedroom_nr != 3) {
            translate([-length/2+wall_thickness/2, 
                window_3_x_pos, 
                window_y + window_h/2]) 
            cube([wall_thickness+1, window_w,  
                window_h],center=true);
        }
        
        /* Window 4 hole */
        if (bedroom_nr != 3) {
            translate([-length/2+wall_thickness/2, 
                -window_3_x_pos, 
                window_y + window_h/2]) 
            cube([wall_thickness+1, window_w,  
                window_h],center=true);
        }
    }
    
    /* Window 3 */
    if (bedroom_nr != 3) {
        translate([-length/2+wall_thickness/2, 
                window_3_x_pos, window_y + window_h/2])
        rotate([0,0,90])
        slidingwindow(window_w, window_h, wall_thickness); 
    }
    
    /* Window 4 */
    if (bedroom_nr != 3) {
        translate([-length/2+wall_thickness/2, 
                window_4_x_pos, window_y + window_h/2])
        rotate([0,0,90])
        slidingwindow(window_w, window_h, wall_thickness); 
    }
}

/* For testing */
bedroomwalls();