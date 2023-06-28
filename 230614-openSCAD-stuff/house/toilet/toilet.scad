 use <toiletseat.scad>
 use <../doors/basicdoor.scad>

module toilet(is_upper_level=true, width=250, length=200, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0) 
{
    // Colors
    toilet_wall_color = [255.0/255, 235/255,20/255];
    
    // Door opening size. We need some extra space for the door frame.
    door_width = 80+5.3;
    door_height = 210+3.2;
    
    // Position the door so that bottom of opening is 5 cm above floor level
    door_y_pos = (wall_height-door_height)/2 - 5;
        
    // Position the door horizontally off the center.
    door_x_pos = -width/5;
    side_door_x_pos = -width/10;
    
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
            color(toilet_wall_color,wall_alpha) 
            cube([length, 0.1, wall_height],center=true);
        }
        if (!is_upper_level) {
           n_holes = 5;
            for (x = [0: n_holes-1]) {
                translate([(x-(n_holes-1)/2) * ((length-4*wall_thickness)/(n_holes-1)),
                -width/2+wall_thickness/2, wall_height/20]) 
                cube([hole_size, 1+wall_thickness, hole_size],center=true);
            }
        }
    
        // Door hole
        if (is_upper_level) {
            translate([side_door_x_pos,-width/2+wall_thickness/2, wall_height/2-door_y_pos]) cube([door_width, wall_thickness+1, door_height],center=true);
        }
    }
    
    /* Door */
    if (is_upper_level) {
        translate([side_door_x_pos,-width/2+wall_thickness/2,
            wall_height/2-door_y_pos]) 
        //rotate([0,0,180])
        basicdoor(door_width, door_height, wall_thickness, true, 45);
    }

    difference() {
        union() {
            translate([0,width/2-wall_thickness/2, wall_height/2]) color(wall_color,wall_alpha) cube([length,  wall_thickness, wall_height],center=true);
            translate([0,width/2-wall_thickness, wall_height/2]) color(toilet_wall_color,wall_alpha) cube([length,  0.1, wall_height],center=true);
        }
     
       n_holes = 5;
        for (x = [0: n_holes-1]) {
            translate([(x-(n_holes-1)/2) * ((length-4*wall_thickness)/(n_holes-1)), width/2-wall_thickness/2, wall_height/20]) cube([hole_size, 1+wall_thickness, hole_size],center=true);
        }
    }
    
    difference() {
        union() {
            translate([length/2-wall_thickness/2, 0, wall_height/2]) color(wall_color,wall_alpha) cube([wall_thickness, width, wall_height],center=true);
            translate([length/2-wall_thickness, 0, wall_height/2]) color(toilet_wall_color,wall_alpha) cube([0.1, width, wall_height],center=true);
        }
        
        n_holes2 = 7;
        for (x = [0: n_holes2-1]) {
            translate([length/2-wall_thickness/2, (x-(n_holes2-1)/2) * ((width-4*wall_thickness)/(n_holes2-1)), wall_height/20]) cube([1+wall_thickness, hole_size, hole_size],center=true);
        }
    }     

    difference() {
        union() {
            translate([-length/2+wall_thickness/2, 0, wall_height/2]) color(wall_color,wall_alpha) cube([wall_thickness, width, wall_height],center=true);
            translate([-length/2+wall_thickness, 0, wall_height/2])  color(toilet_wall_color,wall_alpha) cube([0.1, width, wall_height],center=true);
        }

        /* Door hole */
        if (!is_upper_level) {
           translate([-length/2+wall_thickness/2, door_x_pos, wall_height/2-door_y_pos])
               cube([wall_thickness+1, door_width, door_height],center=true);
        }

        n_holes2 = 7;
        for (x = [0: n_holes2-1]) {
            translate([-length/2+wall_thickness/2, (x-(n_holes2-1)/2) * ((width-4*wall_thickness)/(n_holes2-1)), wall_height/20]) cube([1+wall_thickness, hole_size, hole_size],center=true);
        }
    }

    /* Door */
    if (!is_upper_level) {
        translate([-length/2+wall_thickness/2, door_x_pos, wall_height/2-door_y_pos])
        rotate([0,0,-90])
        basicdoor(door_width, door_height, wall_thickness, true, 45);
    }

    translate([0, -(width-rised_width)/2, rise_floor/2]) cube([length, rised_width, rise_floor],center=true);
    
    color ([0.2, 0.1, 0.0], 1)translate([-(length-double_rised_length)/2, -(width-rised_width)/2, (rise_floor+double_rise_floor)/2]) cube([double_rised_length, rised_width, rise_floor+double_rise_floor ],center=true);
    
    translate([length/2-wall_thickness-10,-rised_width/2+wall_thickness/2,rise_floor]) rotate([0,0,270]) toiletseat();
}

// For testing
toilet();