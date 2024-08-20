//use <bedleg.scad> 
use <hdim.scad> 
//extra_leg_spacing = 1.5;
bighole_diam = 5.0;
bighole_spacing = 0.3;
bighole_pos_coeff = 1.40; 
// leglength=28;

module verticalpair(length = 60.4, wood_w = 15.24, wood_t = 4.5, gap = 0.3) 
{
    translate([0, (wood_w+gap)/2, 0])
    verticalwood(length, wood_w, wood_t);

    translate([0, -(wood_w+gap)/2, 0])
    verticalwood(length, wood_w, wood_t);
}

module verticalwood(length = 60.4, wood_w = 15.24, wood_t = 4.5) 
{
    rotate([90,0,0])
    translate([0,length/2,0])
        color([0.71,0.40,0.11])
        difference() 
    {
        cube([wood_t, length, wood_w],center=true);
        
        translate([0,length/2 - bighole_pos_coeff * wood_t - bighole_diam/2+bighole_spacing,0])
        rotate([0,90,0]) 
        cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);

        translate([0,-length/2 + bighole_pos_coeff * wood_t + bighole_diam/2 - bighole_spacing,0])
        rotate([0,90,0]) 
        cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);
    }
    
 /* 
    translate([-wood_t-wood_w, 
        length/2, 
        -wood_w/2+jw_h-groove_depth+wood_t-leglength/2]) 
    rotate([90,-90,180]) 
    hdim(-leglength/2, leglength/2, jw_h/100, 3);
   
    translate([wood_t,0,0]) rotate([90,0,90])
        hdim(-length/2, length/2, 0, 16);

    translate([wood_t,0,0]) rotate([90,0,90])
        hdim(-length/2, -length/2 + bighole_pos_coeff * wood_t + bighole_diam/2 - bighole_spacing, 0, 4);
    
    w = length-2*wood_w-2*extra_leg_spacing;
    translate([-jw_w/2,0,-wood_w/2-jw_h/2+jw_h-groove_depth+wood_t]) 
        cube([jw_w, w, jw_h],center=true);
    
    translate([-jw_w,0,0]) rotate([90,0,90])
        hdim(-w/2, w/2, 0, 9);
    
    translate([0,length/2,-wood_w/2+jw_h-groove_depth+wood_t]) 
        rotate([0,0,180]) 
        bedleg(wood_t, wood_w, false, leglength);

    translate([0,-length/2,-wood_w/2+jw_h-groove_depth+wood_t]) 
        bedleg(wood_t, wood_w, true, leglength);
        
    translate([wood_t/2,-length/3, 0]) 
    rotate([90,-90,180]) 
    hdim(-wood_w/2, -wood_w/2+jw_h-groove_depth+wood_t, jw_h/100, 14); */
}

verticalpair();