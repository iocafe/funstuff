use <twinwood.scad> 
use <bolt.scad> 

bighole_diam = 5.5;
bolthole_diam = 1.40;
washer_thickness = 0.08;
bighole_spacing = 4.2;

module twinwoodwithholes(wood_l = 120, wood_w = 16, wood_t = 4.5, gap = 0.3, n_braces = 3, hole1=true,hole2=true,explode=false)
{
    delta_y = (wood_w+gap/2)/2;
    
    difference() {
        twinwood(wood_l, wood_w, wood_t, gap, n_braces, explode);
        if (hole1) {
            onebighole(wood_l/2, delta_y, wood_t, true);
            onebighole(wood_l/2, -delta_y, wood_t, true);
        }
        if (hole2) {
            onebighole(-wood_l/2, delta_y, wood_t, false);
            onebighole(-wood_l/2, -delta_y, wood_t, false);
        }
    }
    
    if (hole1) {
        translate([wood_l/2+wood_t+washer_thickness,delta_y,wood_t/2])
        bolt(180, wood_t);
        translate([wood_l/2+wood_t+washer_thickness,-delta_y,wood_t/2])
        bolt(180, wood_t);
    }
    if (hole2) {
        translate([-wood_l/2-wood_t-washer_thickness,delta_y,wood_t/2])
        bolt(0, wood_t);
        translate([-wood_l/2-wood_t-washer_thickness,-delta_y,wood_t/2])
        bolt(0, wood_t);
    }
}

module onebighole(xpos, delta_y, wood_t, right_end)
{
    delta_x = right_end ? - bighole_diam/2 - bighole_spacing : bighole_diam/2 + bighole_spacing;
    
    translate([xpos + delta_x, delta_y,wood_t/2])
        rotate([0,0,0]) 
        cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);

        bolthole_depth = bighole_diam/2 + bighole_spacing;
    
        translate([xpos - (bighole_diam/2 - bighole_spacing)/2,delta_y,wood_t/2])
        rotate([0,90,0]) 
        cylinder(bolthole_depth,r=bolthole_diam/2,center = true, $fn = 18);
}

twinwoodwithholes();