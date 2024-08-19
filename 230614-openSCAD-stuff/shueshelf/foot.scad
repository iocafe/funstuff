module foot(wood_w = 15, wood_t = 5, gap = 0.3)
{
    bighole_diam = 5.5;
    bolthole_diam = 1.2;
    
    translate([0, 0, -wood_w/2]) difference() 
    {
        color([0.75,0.48,0.19, 1.0])
        cube([wood_t, 2*wood_w+gap, wood_w], center = true);

        translate([0, -wood_w/2-gap/4, 0])
        { 
            rotate([0,90,0]) 
            cylinder(h=wood_t+0.5,r=bighole_diam/2,center = true, $fn = 16);

            translate([0, 0, wood_w/4]) 
            cylinder(h=wood_w/2+0.5,r=bolthole_diam/2,center = true, $fn = 16);
        }
        
        translate([0, wood_w/2+gap/4, 0])
        { 
            rotate([0,90,0]) 
            cylinder(h=wood_t+0.5,r=bighole_diam/2,center = true, $fn = 16);

            translate([0, 0, wood_w/4]) 
            cylinder(h=wood_w/2+0.5,r=bolthole_diam/2,center = true, $fn = 16);
        }
    }
}        

foot();