use <kitchenwalls.scad>

module kitchen(width=800, length=600, front_wall_len = 600, back_wall_len = 400, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0, paint_the_room = [0.9, 0.3,0.9]) 
{
    kitchenwalls(width, length, front_wall_len, back_wall_len, wall_thickness, wall_height, wall_color, wall_alpha, paint_the_room);
}

/* For testing */
kitchen();