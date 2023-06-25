use <kitchenwalls.scad>

module kitchen(width=800, length=600, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0, paint_the_room = [0.9, 0.3,0.9]) 
{
    kitchenwalls(width, length, wall_thickness, wall_height, wall_color, wall_alpha, paint_the_room);
}

/* For testing */
kitchen();