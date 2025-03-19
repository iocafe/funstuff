use <washer.scad> 
use <nut.scad> 


module bolt(length = 2.54*1.0, material_thickness = 1.0, 
    diameter = 0.8,
    hex_diameter = 1.5,
    hex_length = 0.68,
    washer_thickness = 0.18) 
{
    color("DeepSkyBlue")
    translate([-washer_thickness,0,0])
    {
        rotate([0,90,0]) 
        {
            cylinder(h=length, r=diameter/2, $fn = 12);
            
            translate([0,0,-hex_length]) 
            cylinder(h=hex_length, r=hex_diameter/2, $fn = 6);
        
            if (material_thickness >= 0) {
              translate([0,0, material_thickness + 2*washer_thickness])
              rotate([0,-90,0]) {
                  washer(0, washer_thickness, 
                      hex_diameter*1.5, diameter+0.05);
                  nut(0, hex_diameter, hex_length, diameter);
              }
            }
        }
        
        washer(0, washer_thickness, hex_diameter*1.5, diameter+0.05);
    }
}

module boltM8(length = 2.54*1.0, material_thickness = 1.0) 
{
    bolt(length, material_thickness, 
        0.8, 1.5, 0.68, 0.18);
}

module boltM6(length = 2.54*1.0, material_thickness = 1.0) 
{
    bolt(length, material_thickness, 
        0.6, 1.15, 0.5, 0.15);
}


boltM8();