use <twinwood.scad> 
use <bolt.scad> 
use <hdim.scad> 

bighole_diam = 5.5;
bolthole_diam = 1.80;
washer_thickness = 0.08;
bighole_spacing = 5.2;

module twinwoodwithholes(wood_l = 120, wood_w = 16, wood_t = 4.5, gap = 0.3, n_braces = 3, hole1=true,hole2=true,explode=false, show_dims=false)
{
    delta_y = (wood_w+gap/2)/2;
    
    difference() {
        twinwood(wood_l, wood_w, wood_t, gap, n_braces, explode, show_dims);
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
        xpos = wood_l/2+wood_t+washer_thickness;
        translate([xpos,delta_y,wood_t/2])
        bolt(180, wood_t);
        translate([xpos,-delta_y,wood_t/2])
        bolt(180, wood_t);
  
        // Dimensioning
        delta_x = -bighole_diam/2 - bighole_spacing;
        translate([wood_l/2 + delta_x, delta_y, wood_t])
        hdim(0, -delta_x, 0, 2*delta_y + bighole_diam);
        translate([wood_l/2 + delta_x, 0, wood_t])
        rotate([0,0,-90]) 
        hdim(-delta_y, delta_y, 0, bighole_diam);
        translate([wood_l/2 + delta_x, 1.5*wood_w+gap, wood_t])
        rotate([0,0,-90]) 
        hdim(delta_y, wood_w+gap/2, 0, 1.3*bighole_diam);

        translate([wood_l/2 - wood_t - delta_x, 0.5*wood_w+gap/2, wood_t/2])
        rotate([90,0,90]) 
        hdim(0, wood_w+gap/2-delta_y, 0, 1.3*bighole_diam);
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
    delta_x = right_end ? -bighole_diam/2 - bighole_spacing : bighole_diam/2 + bighole_spacing;
        
    translate([xpos + delta_x, delta_y,wood_t/2])
    rotate([0,0,0]) 
    cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);

    bolthole_depth = bighole_diam/2 + bighole_spacing;
    bolthole_x = xpos + (right_end ? -bighole_spacing/2 : bighole_spacing/2);

    translate([bolthole_x,delta_y,wood_t/2])
    rotate([0,90,0]) 
    cylinder(bolthole_depth,r=bolthole_diam/2,center = true, $fn = 18);
}

twinwoodwithholes();