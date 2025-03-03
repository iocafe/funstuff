use <washer.scad> 
use <nut.scad> 


module bolt() 
{
    length = 2.54*1.0;
    material_thickness = 1.0;
    thickness = 0.8;
    hex_diameter = 2.0;
    hex_length = 0.7;
    washer_thickness = 0.18;
  
    color("DeepSkyBlue")
    translate([-washer_thickness,0,0])
    {
        rotate([0,90,0]) 
        {
            cylinder(h=length, r=thickness/2, $fn = 12);
            
            translate([0,0,-hex_length]) 
            cylinder(h=hex_length, r=hex_diameter/2, $fn = 6);
        
            translate([0,0, material_thickness + 2*washer_thickness])
            rotate([0,-90,0]) {
                washer(0, washer_thickness);
                nut(0);
            }
        }
        
        washer(0, washer_thickness);
    }
}

bolt();