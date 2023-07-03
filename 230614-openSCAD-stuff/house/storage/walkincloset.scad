use <../doors/basicdoor.scad>

module walkincloset(width=330, length=60, wall_thickness=15, wall_height=260,wall_color=[1,1,1],wall_alpha=1.0) 
{
    /* Door opening size. We need some extra space for the door frame. */
    door_width = 80+5.3;
    door_height = 210+3.2;
    
    /* Position the door so that bottom of opening is 5 cm above floor level */
    door_y_pos = (wall_height-door_height)/2 - 5;
    
    /* Position the door horizontally off the center. */
    door_x_pos = 30;
    
    difference() {
         /* Wall */
        translate([0, -width/2 
            + wall_thickness/2, 
            wall_height/2]) 
        color(wall_color, wall_alpha)
        cube([length, wall_thickness, wall_height],center=true);

     
    }
    
    difference() {
        /* Wall */
        translate([length/2-wall_thickness/2, 0, wall_height/2]) 
        color(wall_color, wall_alpha)
        cube([wall_thickness, width, wall_height],center=true);
    
       /* Door hole  */
        translate([length/2-wall_thickness/2, 
            door_x_pos,
            wall_height/2 - door_y_pos]) 
        color(wall_color, wall_alpha)
        cube([wall_thickness+1, door_width, door_height], center=true);
    }
    
    /* Door */
    translate([length/2-wall_thickness/2, 
            door_x_pos,
            wall_height/2 - door_y_pos]) 
    rotate([0,0,90])
        basicdoor(door_width, door_height, wall_thickness, true, 45);
   
}

// For testing
walkincloset();