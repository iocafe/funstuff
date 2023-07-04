use <../doors/basicdoor.scad>
use <../doors/slidingdoor.scad>
use <../doors/arcdoorhole.scad> 
use <../windows/slidingwindow.scad>

module masterbedroomwalls(width=650, length=700, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0)
{
    // Colors
    paint_the_room = [55.0/255, 235/255,20/255];
    
    // Door opening size. Then we need some extra space for the door frame.
    door_width = 90+5;
    door_height = 210+2.5;
    
    // Position the door so that bottom of opening is 5 cm above floor level
    door_y_pos = (wall_height-door_height)/2 - 5;
        
    // Position the door horizontally off the center.
    door1_x_pos = width/2 - 80;
    door2_x_pos = -width/2 + 125;
    side_door_x_pos = -width/10;
    
    // Rise the part of floor which should stay dry by 2.5 cm.
    rise_floor = 2.5;
    rised_width = width/2;
    
    // Rise walk in floor more to allow sitting to toilet seat with dry feet by 2.0 cm for 100 cm
    double_rise_floor = 2.0;
    double_rised_length = 100;

    /* Arc window */
    arc_window_width = 330;
    arc_window_height = 153;
    arc_window_x_pos = -150;
    
    /* Sliding door to swimming pool terrace */
    sliding_door_width = 270;
    sliding_door_2_width = 270;
    sliding_door_height = 210;
    sliding_door_x_pos = 0;
    sliding_door_2_x_pos = 130;
    sliding_door_y_pos = (wall_height-door_height)/2 - 5;
    
    /* Window positions */
    window_y = 90;
    window_w = 70+5.3;
    window_h = 120+5.3;
    window_1_x_pos = -200;
    window_3_x_pos = -180;
    
    
    difference() {
        union() {
            translate([0,-width/2+wall_thickness/2, wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([length, wall_thickness, wall_height],center=true);
            
            translate([0,-width/2+wall_thickness, wall_height/2]) 
            color(paint_the_room,wall_alpha) 
            cube([length, 0.1, wall_height],center=true);
        }
            
        /* Hole for sliding door to narrow terrace */
        translate([sliding_door_2_x_pos, 
            -width/2+wall_thickness/2,
            wall_height/2 - sliding_door_y_pos])
        color(wall_color, wall_alpha)
        cube([sliding_door_2_width, wall_thickness+1, 
            sliding_door_height], 
            center=true);
        
        /* Window 1 hole */
        translate([window_1_x_pos, 
            -width/2 + wall_thickness/2, 
            window_y + window_h/2]) 
        cube([window_w, wall_thickness+1,   
            window_h],center=true);
    }
    
    /* Window 1 */
    translate([window_1_x_pos, 
        - width/2 + wall_thickness/2,
        window_y + window_h/2]) 
    slidingwindow(window_w, window_h, wall_thickness); 
    
    /* Sliding door to narrow terrace */
    translate([sliding_door_2_x_pos, 
        -width/2+wall_thickness/2,
        wall_height/2 - sliding_door_y_pos])
    slidingdoor(sliding_door_width, sliding_door_height, wall_thickness); 

    difference() {
        union() {
            /* Wall */
            translate([0,
                width/2 - wall_thickness/2, 
                wall_height/2]) 
            color(wall_color, wall_alpha) 
            cube([length,  wall_thickness, wall_height],center=true);
            
            /* Paint the wall */
            translate([0,width/2-wall_thickness, wall_height/2]) 
            color(paint_the_room, wall_alpha) 
            cube([length,  0.1, wall_height],center=true);
        }
        
        /* Arc window hole */
        translate([arc_window_x_pos, 
            width/2 - wall_thickness/2, 
            door_height - arc_window_height + 30])
        arcdoorhole(arc_window_width, arc_window_height,
            wall_thickness, wall_color, 
        wall_alpha);
    }
    
    difference() {
        union() {
            translate([length/2 - wall_thickness/2,
                0, wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([wall_thickness, width, wall_height],center=true);
            
            translate([length/2 - wall_thickness, 
                0, wall_height/2]) 
            color(paint_the_room,wall_alpha) 
            cube([0.1, width, wall_height],center=true);
        }
        
        /* Door 2 hole */
        translate([length/2 - wall_thickness/2, 
            door2_x_pos, 
            wall_height/2 - door_y_pos])
        color(wall_color, wall_alpha)
        cube([wall_thickness+1, 
            door_width, door_height], 
            center=true);
      
        /* Hole for sliding door to pool terrace */
        translate([length/2 - wall_thickness/2, 
            sliding_door_x_pos, 
            wall_height/2 - sliding_door_y_pos])
        color(wall_color, wall_alpha)
        cube([wall_thickness+1, 
            sliding_door_width, sliding_door_height], 
            center=true);
        
    }     
    
    /* Door 2 */
    translate([length/2 - wall_thickness/2,
        door2_x_pos, 
        wall_height/2 - door_y_pos]) 
    rotate([0,0,-90])
    basicdoor(door_width, door_height, wall_thickness, false, 45);   

    /* Sliding door pool terrace */
    translate([length/2 - wall_thickness/2,
        sliding_door_x_pos, 
        wall_height/2 - sliding_door_y_pos]) 
    rotate([0,0,-90])
    slidingdoor(sliding_door_width, sliding_door_height, wall_thickness); 

    difference() {
        union() {
            translate([-length/2+wall_thickness/2,
                0, wall_height/2]) 
            color(wall_color,wall_alpha) 
            cube([wall_thickness, width, wall_height],center=true);
            
            translate([-length/2+wall_thickness, 
                0, wall_height/2])  
            color(paint_the_room,wall_alpha) 
            cube([0.1, width, wall_height],center=true);
        }

        /* Door 1 hole */
        translate([-length/2+wall_thickness/2, 
            door1_x_pos, 
            wall_height/2 - door_y_pos])
        color(wall_color, wall_alpha)
        cube([wall_thickness+1, 
            door_width, door_height], 
            center=true);
        
        /* Window 3 hole */
        translate([-length/2+wall_thickness/2, 
            window_3_x_pos, 
            window_y + window_h/2]) 
        cube([wall_thickness+1, window_w,    
            window_h],center=true);
    }
    
   /* Door 1 */
    translate([-length/2+wall_thickness/2,
        door1_x_pos, 
        wall_height/2 - door_y_pos]) 
    rotate([0,0,-90])
    basicdoor(door_width, door_height, wall_thickness, true, 45);   
   
    /* Window 1 */
    translate([-length/2+wall_thickness/2,
        window_3_x_pos, 
        window_y + window_h/2]) 
    rotate([0,0,90])
    slidingwindow(window_w, window_h, wall_thickness); 
}

// For testing
masterbedroomwalls();