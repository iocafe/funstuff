use <bolt.scad> 

extra_groove_spacing = 1;
extra_leg_spacing = 1.5;
bolthole_diam = 1.30;
washer_thinkness = 0.08;

module bedside(matress_length = 190.5, cw_w = 5.08, cw_h = 15.24, jw_w=4.80, jw_h = 4.8, groove_depth = 1.5) 
{
    translate([0,cw_w/2,0]) {
        color([0.60,0.40,0.08])
        difference() 
        {
            cube([matress_length + 2*cw_w, cw_w+0.05, cw_h],center=true);
            
            translate([0,0,-cw_h/2+jw_h-groove_depth+cw_w/2])
            rotate([90,0,0]) 
            cylinder(h=cw_w+0.25,r=bolthole_diam/2, center = true);
            
            translate([-matress_length/2 - cw_w/2, 0, 0])
            rotate([90,0,0]) 
            cylinder(h=cw_w+0.25,r=bolthole_diam/2, center = true);
            
            translate([matress_length/2 + cw_w/2, 0, 0])
            rotate([90,0,0]) 
            cylinder(h=cw_w+0.25,r=bolthole_diam/2, center = true);
        }
        
        translate([0,cw_w/2+washer_thinkness,-cw_h/2+jw_h-groove_depth+cw_w/2]) bolt(-90,cw_w);
        translate([-matress_length/2 - cw_w/2,cw_w/2+washer_thinkness,0]) bolt(-90,cw_w);
        translate([matress_length/2 + cw_w/2,cw_w/2+washer_thinkness,0]) bolt(-90,cw_w);

        translate([-matress_length/2 + cw_w + cw_h/2,
            cw_w/2+washer_thinkness,-cw_h/2+jw_h]) bolt(-90,cw_w);
        translate([matress_length/2 - cw_w - cw_h/2,
            cw_w/2+washer_thinkness,-cw_h/2+jw_h]) bolt(-90,cw_w);
    }

// bolt(-90);
    
    translate([0,-jw_w/2,-cw_h/2+jw_h/2]) 
    {
        difference() 
        {
            cube([matress_length-2*cw_w-2*cw_h-2*extra_leg_spacing, jw_w, jw_h],center=true);

            translate([0,0,jw_h-groove_depth]) 
                cube([cw_h+extra_groove_spacing, jw_w+0.1, jw_h+0.1],center=true); 
            translate([matress_length/4,0,jw_h-groove_depth]) 
                cube([cw_h+extra_groove_spacing, jw_w+0.1, jw_h+0.1],center=true); 
            translate([-matress_length/4,0,jw_h-groove_depth]) 
                cube([cw_h+extra_groove_spacing, jw_w+0.1, jw_h+0.1],center=true); 
        }
    }
}

bedside();