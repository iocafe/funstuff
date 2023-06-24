 use <bedroomwalls.scad>

module bedroom(width=400, length=400, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255], wall_alpha=1.0, paint_the_room = [0.0, 0.3,0.9]) 
{
    bedroomwalls(width, length, wall_thickness, wall_height ,wall_color,wall_alpha,paint_the_room);
}

// For testing
bedroom();