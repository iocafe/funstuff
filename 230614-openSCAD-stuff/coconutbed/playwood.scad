playwood_thickness = 0.75 * 2.54;
finger_hole_diam = 6.0;
spacing = 0.2;

module playwood(matress_length=190, matress_width = 152.4) 
{
    translate([0,0,playwood_thickness/2])
        difference() 
        {
            color([0.80,0.43,0.32])
            cube([matress_length/2-2*spacing, matress_width-2*spacing, playwood_thickness],center=true);
    
            translate([-matress_length/12, matress_width/2 - finger_hole_diam * 1.5,0])   
                cylinder(r = finger_hole_diam/2, 
                    h = playwood_thickness + 0.1,
                    center=true);
            
            translate([matress_length/12, -matress_width/2 + finger_hole_diam * 1.5,0])   
                cylinder(r = finger_hole_diam/2, 
                    h = playwood_thickness + 0.1,
                    center=true);
        }
}

playwood();