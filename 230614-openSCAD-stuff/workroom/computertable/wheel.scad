// use <washer.scad> 

fixing_plate_t = 0.2;
hinge_cylinder_h = 1.3;
hinge_cylinder_d = 4;


/*
    length = 13.5; // workroom uses 1 cm longer bolts than before
    thickness = 1.2;
    hex_diameter = 2.0;
    hex_length = 0.7;
    washer_thickness = 0.18;
    bighole_pos_coeff = 1.4; 
 
    rotate([0,90,rotation]) color([0.4,0.4,0.8])
    {
        cylinder(h=length, r=thickness/2, $fn = 12);
        
        translate([0,0,-hex_length]) 
            cylinder(h=hex_length, r=hex_diameter/2, $fn = 6);
    
        translate([0,0,cw_w + bighole_pos_coeff * cw_w+2*washer_thickness]) rotate([0,-90,0]) {
            washer(0, washer_thickness);
            nut(0);
        }
    }
    
    washer(rotation, washer_thickness);
    
}
*/

module wheel_assembly()
{
    fixing_plate();
    hinge_cylinder(-fixing_plate_t);
    wheel(-fixing_plate_t-hinge_cylinder_h);
    wheel_fixture(-fixing_plate_t-hinge_cylinder_h/2);
}

module fixing_plate()
{
    fixing_plate_l = 6;
    fixing_plate_w = 5;
    rounded_end_d = 0.5;
    hole_dx = 0.8;
    hole_dy = 0.9;
    
    translate([0,0,-fixing_plate_t/2]) 
    difference()
    {
        minkowski()
        {
            cube([fixing_plate_l-rounded_end_d, fixing_plate_w-rounded_end_d, 0.001], center = true);
            cylinder(d=rounded_end_d,h=fixing_plate_t, center=true, $fn = 22);
        }
        translate([(fixing_plate_l/2-hole_dx),(fixing_plate_w/2-hole_dy),0]) 
        fixing_plate_hole();
        translate([(fixing_plate_l/2-hole_dx),-(fixing_plate_w/2-hole_dy),0]) 
        fixing_plate_hole();
        translate([-(fixing_plate_l/2-hole_dx),(fixing_plate_w/2-hole_dy), 0]) 
        fixing_plate_hole();
        translate([-(fixing_plate_l/2-hole_dx),-(fixing_plate_w/2-hole_dy),0]) 
        fixing_plate_hole();
    }
}

module fixing_plate_hole()
{
    hole_size = 0.7;
    center_points_d = 0.25;
    hole_h = fixing_plate_t + 0.1;

    hull() {
        translate([0,-center_points_d/2,0])
        cylinder(h=hole_h, d=hole_size, center = true, $fn = 16);

        translate([0,center_points_d/2,0])
        cylinder(h=hole_h, d=hole_size, center = true, $fn = 16);
    }
}

module hinge_cylinder(top_y)
{
    
    translate([0,0,top_y-hinge_cylinder_h/2])
    cylinder(d=hinge_cylinder_d,h=hinge_cylinder_h, center=true, $fn = 33);
}

module wheel(top_y)
{
    wheel_d = 5;
    wheel_t = 2.3;
    wheel_dz = 3.3;
    wheel_dx = 2.5;

    translate([wheel_dx,0,top_y-wheel_dz])
    rotate([90,0,0])
    cylinder(d=wheel_d,h=wheel_t, center=true, $fn = 33);
}

module wheel_fixture(top_y)
{
    translate([0,0,top_y])
    rotate([-90,0,0])
    linear_extrude(3, center = true) 
        polygon(points=[[-hinge_cylinder_d/2,0],
            [hinge_cylinder_d/2, 0],
            [2.5, 0.5],
            [2.8, 5.3],
            [1.8, 5.0]]);
 
}

wheel_assembly();