module kitchendoor(door_width=300, door_height=260,wall_thickness=15, wall_color=[0,0,1],wall_alpha=0.3)
{
    $fn = 50;
    r = 1.4 * door_width;
    dx = door_width / 2; 
    
    intersection() {
        color(wall_color,wall_alpha) 
        translate([0,0,door_height/2-0.1])
        cube([door_width, wall_thickness+0.2, door_height],center=true);
        
        color(wall_color,wall_alpha)
        translate([0,0, door_height - r])
        rotate([90,0,0]) 
        cylinder(h=wall_thickness+0.2, r=r, center=true); 
    }
}

// For testing
kitchendoor();