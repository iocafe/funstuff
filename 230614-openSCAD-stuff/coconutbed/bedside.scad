use <bolt.scad> 
use <hdim.scad> 

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
        
        translate([0, cw_w/2, 0]) rotate([90,0,180]) {
            hdim(matress_length/2 + cw_w/2, matress_length/2 + cw_w, 0, 2);
            hdim(-matress_length/2 - cw_w, matress_length/2 + cw_w, 0, 20);
            hdim(matress_length/2 - cw_w - cw_h/2, matress_length/2 + cw_w, -jw_h/14, 8);
        }
        
        translate([0, cw_w/2, 0]) rotate([90,90,180]) {
            hdim(cw_h/2-jw_h+groove_depth-cw_w/2, cw_h/2, jw_h/100, 3);
        }
        translate([matress_length/2 - cw_w - cw_h/2, cw_w/2, 0]) rotate([90,90,180]) {
            hdim(cw_h/2-jw_h, cw_h/2, jw_h/100, 3);
        }
        
        translate([-matress_length/2 + cw_w + cw_h/2,
            cw_w/2+washer_thinkness,-cw_h/2+jw_h]) bolt(-90,cw_w);
        translate([matress_length/2 - cw_w - cw_h/2,
            cw_w/2+washer_thinkness,-cw_h/2+jw_h]) bolt(-90,cw_w);
    }

// bolt(-90);
    
    groove_w = cw_h+extra_groove_spacing;
    translate([0,-jw_w/2,-cw_h/2+jw_h/2]) 
    {
        l = matress_length-2*cw_w-2*cw_h-2*extra_leg_spacing;
        difference() 
        {
            cube([l, jw_w, jw_h],center=true);

            translate([0,0,jw_h-groove_depth]) 
                cube([groove_w, jw_w+0.1, jw_h+0.1],center=true); 
            translate([matress_length/4,0,jw_h-groove_depth]) 
                cube([groove_w, jw_w+0.1, jw_h+0.1],center=true); 
            translate([-matress_length/4,0,jw_h-groove_depth]) 
                cube([groove_w, jw_w+0.1, jw_h+0.1],center=true); 
        }
        
        translate([0,-cw_w/2, 0]) rotate([90,0,0])
        {
            hdim(-l/2, l/2, -jw_h/4, 5);
        
            hdim(-groove_w/2, groove_w/2, -jw_h/4, 10);

            hdim(matress_length/4+groove_w/2, l/2, -jw_h/4, 14);
        } 
    }
}

bedside();