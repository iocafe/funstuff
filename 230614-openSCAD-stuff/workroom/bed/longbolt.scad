use <washer.scad> 
use <nut.scad> 

module longbolt(rotation=0) 
{
    length = 21;
    thickness = 1.2;
    hex_diameter = 2.0;
    hex_length = 0.7;
    washer_thickness = 0.18;
    bighole_pos_coeff = 0.01; 
    cw_w=4.2;
 
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

longbolt();