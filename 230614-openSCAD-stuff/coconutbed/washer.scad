module washer(rotation=0) 
{
    diameter = 3.1;
    thickness = 0.08;
    hole = 1.25;
 
    
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