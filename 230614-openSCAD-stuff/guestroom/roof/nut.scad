module nut(rotation=0) 
{
    hex_diameter = 1.5;
    hex_length = 0.7;
    hole = 0.80;
     
    rotate([0,90,rotation]) 
    color([0.0,0.8,1.0])
    translate([0,0,hex_length*0.5]) 
    {
        difference() {
            cylinder(h=hex_length, r=hex_diameter/2, $fn = 6, center=true);
            cylinder(h=hex_length+0.1, r=hole/2, $fn = 12, center=true);
        }
    }
}

nut();