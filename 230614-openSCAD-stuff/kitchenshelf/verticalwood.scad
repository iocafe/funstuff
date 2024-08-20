use <hdim.scad> 
use <bolt.scad> 
bighole_diam = 5.0;
bighole_delta = 12.0;

module verticalpair(length = 60.4, wood_w = 15.24, wood_t = 4.5, gap = 0.3, bolt_left=25, bolt_right=35) 
{
    translate([0, (wood_w+gap)/2, 0])
    verticalwood(length, wood_w, wood_t, bolt_left, bolt_right);

    translate([0, -(wood_w+gap)/2, 0])
    verticalwood(length, wood_w, wood_t, bolt_left, bolt_right);

    rotate([0,-90,0])
        hdim(0, length, 0, 20);

    translate([wood_t/2,-wood_w/2, 0]) rotate([0,-90,0])
        hdim(0, bighole_delta-wood_t, 0, 20);
}

module verticalwood(length = 60.4, wood_w = 15.24, wood_t = 4.5, bolt_left, bolt_right) 
{
    rotate([90,0,0])
    translate([0,length/2,0])
        color([0.71,0.40,0.11])
        difference() 
    {
        cube([wood_t, length, wood_w],center=true);
        
        translate([0,length/2 + wood_t - bighole_delta,0])
        rotate([0,90,0]) 
        cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);

        translate([0,-length/2 - wood_t + bighole_delta,0])
        rotate([0,90,0]) 
        cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);
    }
    
    if (bolt_left != 0) {
        translate([-wood_t/2, 0, bolt_left])
        // rotate([0, -90, 0])
        bolt(0);
    }

    if (bolt_right != 0) {
        translate([wood_t/2, 0, bolt_right])
        // rotate([0, -90, 0])
        bolt(180);
    }
}

verticalpair();