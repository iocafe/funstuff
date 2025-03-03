use <../metals.scad> 
use <bolt.scad> 

roof_overlap = 100;
roof_angle = 23;

c_bar_width = 1.5 * 2.54;
c_bar_height = 3 * 2.54;
c_bar_color = "DarkGray";

bolt_material_and_washer_thickn = 1.2;

module roof_truss(width = 400)
{
    part1 = 3*width/4 + 40;
    translate([(-width+part1)/2,0,0])
    c_bar(part1, "DarkSlateGray", c_bar_width, c_bar_height); 
    
    part2 = width/4 + 40;
    translate([(width-part2)/2,0,0])
    rotate([180,0,0]) c_bar(part2, "SlateGray", c_bar_width, c_bar_height); 

    part3_move = 20;
    part3 = (width/2-part3_move) * tan(roof_angle) + 0.8*c_bar_height;
    translate([part3_move,0,part3/2 - 0.52*c_bar_height])
    rotate([180,90,0]) c_bar(part3, "Gray", c_bar_width, c_bar_height); 

    l1 = (width/2) / cos(roof_angle);
    rotated_c_bar(l1, roof_angle, false, width/2);

    l2 = l1 + roof_overlap;
    rotated_c_bar(l2, roof_angle, true, width/2, "SlateGrey");
    
    translate([-width/2 + 0.6*c_bar_height,
        -bolt_material_and_washer_thickn/2,
        0.2*c_bar_height])
    rotate([0,0,90]) bolt();

    translate([width/2 - 0.6*c_bar_height,
        -bolt_material_and_washer_thickn/2,
        0.2*c_bar_height])
    rotate([0,0,90]) bolt();

    translate([1*width/4 + 30,
        -bolt_material_and_washer_thickn/2, 0])
    rotate([0,0,90]) bolt();

    translate([1*width/4 - 30,
        -bolt_material_and_washer_thickn/2, 0])
    rotate([0,0,90]) bolt();

    translate([part3_move,
        -bolt_material_and_washer_thickn/2, 0])
    rotate([0,0,90]) bolt();
    
    translate([part3_move,
        -bolt_material_and_washer_thickn/2, part3-c_bar_height])
    rotate([0,0,90]) bolt();

    top_bolt_y = width/2 * tan(roof_angle);
    translate([2,
        -bolt_material_and_washer_thickn/2, top_bolt_y])
    rotate([0,0,90]) bolt();
}

module rotated_c_bar(length, angle, flip, move_x, c = "DarkGrey")
{
    dx = length/2;
    dz = c_bar_height/2;

    if (flip) {
        
        translate([-move_x, 0, dz])
        rotate([0,-angle,0])
        translate([dx, 0, -dz])
        rotate([180,0,0])
        c_bar(length, c, c_bar_width, c_bar_height); 
    }
    else {
        translate([move_x, 0, dz])
        rotate([0,angle,0])
        translate([-dx, 0, -dz])
        c_bar(length, c, c_bar_width, c_bar_height); 
    }
}

roof_truss();