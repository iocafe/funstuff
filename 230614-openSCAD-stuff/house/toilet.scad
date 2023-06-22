 use <toiletseat.scad>

module toilet(width=250, length=200, wall_thickness=15, wall_height=260) 
{
    
    // Door opening size. Then we need some extra space for the door frame.
    door_width = 70+5;
    door_height = 210+2.5;
    
    // Position the door so that bottom of opening is 5 cm above floor level
    door_y_pos = (wall_height-door_height)/2 - 5;
    
    // Position the door horizontally off the center.
    door_x_pos = -width/5;
    
    // Rise floor which should stay dry by 2.5 cm
    rise_floor = 2.5;
    rised_width = width/2;
    
    // Rise walk in floor more to allow sitting to toilet seat with dry feet by 2.0 cm for 100 cm
    double_rise_floor = 2.0;
    double_rised_length = 100;
    
    // Hole size, 8 cm
    hole_size = 8;

difference() {
    translate([0,-width/2+wall_thickness/2, wall_height/2]) cube([length, wall_thickness, wall_height],center=true);

   n_holes = 5;
    for (x = [0: n_holes-1]) {
        translate([(x-(n_holes-1)/2) * ((length-4*wall_thickness)/(n_holes-1)), -width/2+wall_thickness/2, wall_height/20]) cube([hole_size, 1+wall_thickness, hole_size],center=true);
    }
}

    difference() {
        translate([0,width/2-wall_thickness/2, wall_height/2]) cube([length, wall_thickness, wall_height],center=true);
     
       n_holes = 5;
        for (x = [0: n_holes-1]) {
            translate([(x-(n_holes-1)/2) * ((length-4*wall_thickness)/(n_holes-1)), width/2-wall_thickness/2, wall_height/20]) cube([hole_size, 1+wall_thickness, hole_size],center=true);
        }
    }
    
    difference() {
        translate([length/2-wall_thickness/2, 0, wall_height/2]) cube([wall_thickness, width, wall_height],center=true);
        
        n_holes2 = 7;
        for (x = [0: n_holes2-1]) {
            translate([length/2-wall_thickness/2, (x-(n_holes2-1)/2) * ((width-4*wall_thickness)/(n_holes2-1)), wall_height/20]) cube([1+wall_thickness, hole_size, hole_size],center=true);
        }
    }     

    difference() {
        translate([-length/2+wall_thickness/2, 0, wall_height/2]) cube([wall_thickness, width, wall_height],center=true);

        translate([-length/2+wall_thickness/2, door_x_pos, wall_height/2-door_y_pos]) cube([wall_thickness+1, door_width, door_height],center=true);
    }

    translate([0, -(width-rised_width)/2, rise_floor/2]) cube([length, rised_width, rise_floor],center=true);
    
    color ([0.2, 0.1, 0.0], 1)translate([-(length-double_rised_length)/2, -(width-rised_width)/2, (rise_floor+double_rise_floor)/2]) cube([double_rised_length, rised_width, rise_floor+double_rise_floor ],center=true);
    
    translate([length/2-wall_thickness-10,-rised_width/2+wall_thickness/2,rise_floor]) rotate([0,0,270]) toiletseat();
}

// For testing
toilet();