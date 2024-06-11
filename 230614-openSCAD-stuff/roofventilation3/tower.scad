// use <wall.scad>
use <roof.scad>
use <longwall.scad>
use <shortwall.scad>

module tower() 
{
    explode = false;
    show_roof = true;
    window_open_angle = 92;
    
    box_height = 80;
    box_length = 460.0 - 10;
    box_width = 169.5+10;
    overlap = 67;
    roof_angle = 13.5;
    corner_diam = 40;
    lprofile_width=2.54;
    lprofile_thickness=0.3;
    playwood_thickness = 2.54 * 0.75;
    metal_thickness = 1;
    expd = explode ? 120 : 0;
    
    
    translate([0,-box_width/2 - expd,0]) 
    longwall(roof_angle, box_height, box_length, 
        lprofile_width, lprofile_thickness, 
        playwood_thickness,
        window_open_angle, corner_diam, explode); 

    translate([0,box_width/2 + expd,0]) 
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
        
    // Safety top playwood
    translate([0,0, playwood_thickness/2])
    color([0.8, 0.8, 0.0, 0.4])
    cube([box_length, box_width, playwood_thickness], center=true);

    // Roof
    roof_pos = (box_width/2 + 2*corner_diam/3) * tan(roof_angle);
    if (show_roof) {
        translate([0,0, roof_pos + (explode ? 250 : 0)]) 
        roof(box_length, box_width, overlap, roof_angle, metal_thickness, explode);
        translate([0,0, roof_pos + (explode ? 280 : 20)]) 
        text(str(box_width/2 * tan(roof_angle)), size = 10, 
                halign = "center",valign = "center"); 
    }
}


tower();