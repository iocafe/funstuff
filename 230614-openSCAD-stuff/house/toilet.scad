module toilet(width=250, length=200, wall_thickness=15, wall_height=260) 
{
// Door opening size. Then we need some extra space for the door frame.
    door_width = 70+5;
    door_height = 210+2.5;
    
    // Position the door so that bottom of opening is 5 cm above floor level
    door_y_pos = (wall_height-door_height)/2 - 5;
    
    // Position the door horizontally off the center.
    door_x_pos = -width/6;
    
    // Rise floor which should stay dry by 2.5 cm
    rise_floor = 2.5;
    rised_width = width/2;
    
    // Hole size, 8 cm
    hole_size = 8;
        
    translate([0,width/2-wall_thickness/2, wall_height/2]) cube([length, wall_thickness, wall_height],center=true);
        
    translate([0,-width/2+wall_thickness/2, wall_height/2]) cube([length, wall_thickness, wall_height],center=true);
    
    translate([length/2-wall_thickness/2, 0, wall_height/2]) cube([wall_thickness, width, wall_height],center=true);
    
    for (x = [-2: 2]) {
    translate([length/2-wall_thickness/2, x * 20, wall_height/2]) cube([wall_thickness, hole_size, hole_size],center=true);
    }
    
    difference() {
        translate([-length/2+wall_thickness/2, 0, wall_height/2]) cube([wall_thickness, width, wall_height],center=true);

        translate([-length/2+wall_thickness/2, door_x_pos, wall_height/2-door_y_pos]) cube([wall_thickness+1, door_width, door_height],center=true);
    }

    translate([0, -(width-rised_width)/2, rise_floor/2]) cube([length, rised_width, rise_floor],center=true);
    
    // toilet_seat();
}


module toilet_seat(width=250, length=200) 
{
    // Change these
height=13;
topLength=42;
bottomLength=52;
topWidth=15;
bottomWidth=19;
lipHeight=4;
lipDepth=2;
$fn = 60;

// Leave these alone
topRadius=topWidth/2;
bottomRadius=bottomWidth/2;
polyLength=topLength-topRadius; // Not topLength-2*topRadius because 1st cylindar is centered on 0

hull(){

  translate([0,0,lipHeight])
    cylinder(r1=bottomRadius, r2=topRadius, h=height-lipHeight, center=false);

  translate([0,polyLength,lipHeight])
    cylinder(r1=bottomRadius, r2=topRadius, h=height-lipHeight, center=false);
}

// Now the lip
hull(){

  translate([0,0,0])
    cylinder(r1=bottomRadius+lipDepth, r2=bottomRadius+lipDepth,, h=lipHeight, center=false);

  translate([0,polyLength,0])
    cylinder(r1=bottomRadius+lipDepth, r2=bottomRadius+lipDepth, h=lipHeight, center=false);
}

    
}

// For testing
toilet();