use <wall.scad>
use <roof.scad>

module tower(width=180, height=100, wall_thickness=10) 
{
     
    translate([0,0,height/2+30]) roof(350, 50);
    
    translate([0, (width-wall_thickness)/2, 0]) 
    wall(width, height, wall_thickness);

    translate([0, -(width-wall_thickness)/2, 0]) 
    wall(width, height, wall_thickness);

    translate([-(width-wall_thickness)/2, 0, 0]) 
    rotate([0,0,90]) 
    wall(width, height, wall_thickness);

    translate([(width-wall_thickness)/2, 0, 0]) 
    rotate([0,0,90]) 
    wall(width, height, wall_thickness);
}


tower();