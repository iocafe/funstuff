use <../doors/basicdoor.scad>

module pumproom(width=120, length=200, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0) 
{
    /* Door opening size. We need some extra space for the door frame. */
    door_width = 80+5.3;
    door_height = 210+3.2;
    
    // Position the door so that bottom of opening is 5 cm above floor level
    door_y_pos = (wall_height-door_height)/2 - 5;
    
    // Position the door horizontally off the center.
    door_x_pos = -5;
   
    // Hole size, 8 cm
    hole_size = 8;

difference() {
    
    translate([0,-width/2+wall_thickness/2, wall_height/2]) 
    color(wall_color, wall_alpha)
    cube([length, wall_thickness, wall_height],center=true);

   n_holes = 5;
    for (x = [0: n_holes-1]) {
        translate([(x-(n_holes-1)/2) * ((length-4*wall_thickness)/(n_holes-1)),
            -width/2+wall_thickness/2, wall_height/20]) 
        color(wall_color, wall_alpha)
        cube([hole_size, 1+wall_thickness, hole_size],center=true);
    }
}

    difference() {
        translate([0,width/2-wall_thickness/2, 
            wall_height/2]) 
        color(wall_color, wall_alpha)
        cube([length, wall_thickness, wall_height],center=true);
     
       n_holes = 5;
        for (x = [0: n_holes-1]) {
            translate([(x-(n_holes-1)/2) * ((length-4*wall_thickness)/(n_holes-1)),
                width/2-wall_thickness/2, wall_height/20]) 
            color(wall_color, wall_alpha)
            cube([hole_size, 1+wall_thickness, hole_size],center=true);
        }
    }
    
    difference() {
        translate([length/2-wall_thickness/2, 0, wall_height/2]) 
        color(wall_color, wall_alpha)
        cube([wall_thickness, width, wall_height],center=true);
        
        n_holes2 = 3;
        for (x = [0: n_holes2-1]) {
            translate([length/2-wall_thickness/2, 
                (x-(n_holes2-1)/2) * ((width-4*wall_thickness)/(n_holes2-1)),
                wall_height/20]) 
            color(wall_color, wall_alpha)
            cube([1+wall_thickness, hole_size, hole_size],center=true);
        }
    }     

    difference() {
        translate([-length/2+wall_thickness/2, 0, wall_height/2])
        color(wall_color, wall_alpha)
        cube([wall_thickness, width, wall_height],center=true);

        translate([-length/2+wall_thickness/2,
            door_x_pos, 
            wall_height/2 - door_y_pos]) 
        color(wall_color, wall_alpha)
        cube([wall_thickness+1, door_width, door_height], center=true);
    }
    
    /* Door */
    translate([-length/2+wall_thickness/2,
        door_x_pos, 
        wall_height/2 - door_y_pos]) 
    rotate([0,0,-90])
    basicdoor(door_width, door_height, wall_thickness, true, 45);
}

// For testing
pumproom();