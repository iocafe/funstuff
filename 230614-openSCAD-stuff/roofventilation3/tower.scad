// use <wall.scad>
use <roof.scad>
use <longwall.scad>
use <shortwall.scad>

module tower() 
{
    explode = false;
    window_open_angle = 92;
    
    box_height = 80;
    box_length = 460.0;
    box_width = 169.5;
    overlap = 80;
    roof_angle = 13.5;
    corner_diam = 40;
    lprofile_width=2.54;
    lprofile_thickness=0.3;
    playwood_thickness = 2.54 * 0.75;
    metal_thickness = 1;
    
    roof_pos = (box_width/2 + corner_diam) * tan(roof_angle);
    translate([0,0, roof_pos + (explode ? 250 : 0)]) 
    roof(box_length, box_width, overlap, roof_angle, metal_thickness, explode); 
   
    translate([0,-box_width/2,0]) 
    longwall(roof_angle, box_height, box_length, 
        lprofile_width, lprofile_thickness, 
        playwood_thickness,
        window_open_angle, corner_diam, explode); 

    translate([0,box_width/2,0]) 
    rotate([0,0,180])
    longwall(roof_angle, box_height, box_length, 
        lprofile_width, lprofile_thickness, 
        playwood_thickness,
        window_open_angle, corner_diam, explode); 

    translate([-box_length/2,0,0])
    rotate([0,0,270])
    shortwall(roof_angle, box_height, box_width, 
        lprofile_width, lprofile_thickness, 
        playwood_thickness,
        window_open_angle, explode); 

    translate([box_length/2,0,0])
    rotate([0,0,90])
    shortwall(roof_angle, box_height, box_width, 
        lprofile_width, lprofile_thickness, 
        playwood_thickness,
        window_open_angle, explode); 
}


tower();