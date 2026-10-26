use <washer.scad> 
use <nut.scad> 

module bolt(length = 4, thickness = 0.6, rotation=0, cw_w=0.2) 
{
    hex_diameter = 1.1;
    hex_length = 0.3;
    washer_thickness = 0.18;
 
    translate([-washer_thickness,0,0])
    {
        rotate([0,90,rotation]) 
        {
            color([0.4,0.4,0.8])
            cylinder(h=length, r=thickness/2, $fn = 12);
            
            color([0.4,0.4,0.8])
            translate([0,0,-hex_length]) 
                cylinder(h=hex_length, r=hex_diameter/2, $fn = 6);
        
            translate([0,0,cw_w + washer_thickness]) rotate([0,-90,0]) {
                color([0.0,0.8,1.0]) 
                washer(0, washer_thickness);
                color([0.4,0.4,0.8])
                nut(0);
            }
        }
        
        color([0.0,0.8,1.0])
        washer(rotation, washer_thickness);
    }
}

bolt();