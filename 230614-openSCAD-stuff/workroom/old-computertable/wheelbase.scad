use <wheel.scad> 

wb_dx = 1.0*2.54;
wheel_dist = 45;

module wheel_base(leg_dist = 50, wood_w = 7, wood_h = 5, hole_diam = 2.54, hole_depth=3)
{
    wheel_base2(leg_dist, wood_w, wood_h, hole_diam);
    
    translate([wheel_dist/2,0, 0])
    //rotate([0,0,90])
    wheel_assembly();
    translate([-wheel_dist/2,0, 0])
    wheel_assembly();
}

module wheel_base2(leg_dist = 50, wood_w = 7, wood_h = 5, hole_diam = 2.54, hole_depth=3)
{
    translate([0,0,wood_h/2]) color([166/255, 90/255, 23/255, 1]) difference()
    {
        cube([leg_dist+2*wb_dx, wood_w, wood_h], center=true);

        translate([leg_dist/2,0, wood_h-hole_depth])
        cylinder(d=hole_diam,h=wood_h+0.1, center=true, $fn = 33);

        translate([-leg_dist/2,0, wood_h-hole_depth])
        cylinder(d=hole_diam,h=wood_h+0.1, center=true, $fn = 33);
    }
}


wheel_base();