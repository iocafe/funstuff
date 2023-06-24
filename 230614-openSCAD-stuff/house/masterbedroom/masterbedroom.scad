 use <masterbedroomwalls.scad>

module masterbedroom(width=250, length=200, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0) 
{
    masterbedroomwalls(width, length, wall_thickness, wall_height ,wall_color,wall_alpha);
}

// For testing
masterbedroom();