use <vertical2x2.scad>
use <playwood.scad>

module corner(corner_diam = 40, corner_height = 100, playwood_thickness= 1.5, roof_angle=20) 
{
    wood_2x2_width = 4; 
    delta = playwood_thickness + wood_2x2_width/2;
    
    x1 = delta;
    y1 = delta;
    x2 = corner_diam - delta;
    y2 = corner_diam - delta;
    h1 = corner_height - y1 * tan(roof_angle);
    h2 = corner_height - y2 * tan(roof_angle);
    
    translate([x1, y1, 0])
    vertical2x2(h1, wood_2x2_width, roof_angle);
    
    translate([x2, y1, 0])
    vertical2x2(h1, wood_2x2_width, roof_angle);
    
    translate([x1, y2, 0])
    vertical2x2(h2, wood_2x2_width, roof_angle);
    
    translate([x2, y2, 0])
    vertical2x2(h2, wood_2x2_width, roof_angle);
    
    translate([0,playwood_thickness,0])
    playwood(corner_diam-2*playwood_thickness, corner_height-playwood_thickness*tan(roof_angle), playwood_thickness, roof_angle); 

    translate([corner_diam-playwood_thickness,playwood_thickness,0])
    playwood(corner_diam-2*playwood_thickness, corner_height-playwood_thickness*tan(roof_angle), playwood_thickness, roof_angle); 

    translate([0,playwood_thickness,0])
    rotate([0,0,270])
    playwood(corner_diam, corner_height - playwood_thickness*tan(roof_angle),  playwood_thickness, 0); 

    translate([0,corner_diam,0])
    rotate([0,0,270])
    playwood(corner_diam, corner_height - (corner_diam)*tan(roof_angle),  playwood_thickness, 0); 

    // playwood(corner_diam, corner_height, playwood_thickness, roof_angle); 
}


corner();