use <washer.scad> 
use <nut.scad> 

module bolt(rotation=0, cw_w=5) 
{
    length = 13;
    thickness = 1.2;
    hex_diameter = 1.9;
    hex_length = 0.8;
    washer_thickness = 0.08;
 
    rotate([0,90,rotation]) color([0.4,0.4,0.8])
    {
        cylinder(h=length, r=thickness/2, $fn = 12);
        
        translate([0,0,-hex_length]) 
            cylinder(h=hex_length, r=hex_diameter/2, $fn = 6);
    
        translate([0,0,2*cw_w+2*washer_thickness]) rotate([0,-90,0]) {
            washer(0);
            nut(0);
        }
    }
    
    washer(rotation);
    
}

bolt();