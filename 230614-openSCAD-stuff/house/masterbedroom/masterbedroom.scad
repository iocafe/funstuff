use <masterbedroomwalls.scad>
use <../storage/walkincloset.scad>

module masterbedroom(width=600, length=600, wall_thickness=15, wall_height=260,wall_color=[255/255, 255/255, 255/255],wall_alpha=1.0) 
{
    masterbedroomwalls(width, length,
        wall_thickness, wall_height, 
        wall_color, wall_alpha);

    closet_w = 300;
    closet_l = 170;

    translate([width/2 - closet_w/2 - 2*wall_thickness, length/2 - closet_l/2, 0])
    rotate([0,0,-90])
    walkincloset(closet_w, closet_l, 
        wall_thickness, wall_height,
        wall_color, wall_alpha);
}

// For testing
masterbedroom();