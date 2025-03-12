module washer(rotation=0, thickness = 0.08, diameter = 2.1,
    hole = 0.85) 
{
    rotate([0,90,rotation]) 
    color([0.0,0.8,1.0])
    translate([0,0,thickness*0.5]) 
    {
        difference() {
            cylinder(h=thickness, r=diameter/2, $fn = 22, center=true);
            cylinder(h=thickness+0.1, r=hole/2, $fn = 12, center=true);
        }
    }
}

washer();