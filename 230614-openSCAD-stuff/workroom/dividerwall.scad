use <bolt.scad> 
use <pipe.scad> 
use <shelf.scad> 
use <foot.scad> 
use <twinwood.scad>
use <bed/bed.scad> 

module dividerwall(shelf_w = 330, shelf_h = 210, wood_w = 15,    // Coconut wood width
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.2,// Gimelina wood thickness
    pipe_diam = 2.54,
    fridgebox_depth = 80,
    explode = false)
{
    bed_height = 34;
    gap_washer = 1.5;
    matress_length = 190.2;
    matress_width = 80.8;
    bed_length = matress_length + 2*wood_t;
    bed_width = matress_width + 2*wood_t;
    
    translate([0,0,gim_t])
    dividerwall2(shelf_w, shelf_h, bed_length+2*gap_washer, bed_width, wood_w, wood_t, gim_t, pipe_diam, fridgebox_depth, explode);
    
    bed_angle = ($t > 0.5) ? (180 - 180 * $t) : (180 * $t);
    translate([bed_length/2+wood_t+gap_washer,0,bed_height - wood_t/2])
    rotate([bed_angle,0,0])
    coconutbed(matress_length, matress_width, wood_w, wood_t, pipe_diam, gap_washer, bed_height, explode);
}

module dividerwall2(shelf_w = 330, 
    shelf_h = 210, 
    bedbox_length = 225, 
    bed_width = 90, 
    wood_w = 15,    // Coconut wood width
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.2,     // Gimelina wood thickness
    pipe_diam = 2.54,
    fridgebox_depth = 80,
    explode = false)
{
    gap = 0.3;      // Gap between wood planks of one shelf
   
    bottom_wood_l = shelf_w - fridgebox_depth;
    bedbox_x = bottom_wood_l/2; // + bedbox_length +2*wood_t;
    translate([bedbox_x + 0,0,0])
    twinwood(bottom_wood_l, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
    
    bedbox_h = 120;
    translate([bedbox_length+2*wood_t,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwood(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
    translate([wood_t,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwood(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

    translate([bottom_wood_l,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwood(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
   
    foot_z = explode ? -20 : 0;
    n_feet = 4;
    foot_start = 12;
    foot_span = bottom_wood_l - 2 * foot_start;
    foot_step = foot_span / (n_feet - 1); 
    for (foot_i = [0:n_feet-1]) {
        translate([bedbox_x-foot_span/2+foot_i * foot_step,0,foot_z])
        foot(wood_w, gim_t, gap);
    }

    bedbox_top_wood_l = bedbox_length + 2 * wood_t;
    translate([bedbox_x,0,bedbox_h + wood_t])
    twinwood(bottom_wood_l, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

    full_shelf_1_h = 29;
    full_shelf_lenth = shelf_w - 2*wood_w - gap;
    full_shelf_1_y = bedbox_h + 2 * wood_t + full_shelf_1_h;
    translate([full_shelf_lenth/2,0,full_shelf_1_y])
    twinwood(full_shelf_lenth, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
    
    full_shelf_2_h = 39;
    full_shelf_2_y = full_shelf_1_y + wood_t + full_shelf_2_h;
    translate([full_shelf_lenth/2,0,full_shelf_2_y])
    twinwood(full_shelf_lenth, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
 
    pipe_dx=wood_t/2;      // Distance of pipe from end of the self
    pipe_dy=4;
   
    pipe_length_long = full_shelf_1_h + full_shelf_2_h + 3 * wood_t;
    
    pipe_z_long = bedbox_h + wood_t;
    pipe_y1 = wood_w + gap/2 - pipe_dy;
    hole_y1 = full_shelf_1_h + wood_t - 0.5;
    hole_y2 = hole_y1 + full_shelf_2_h + wood_t;
    
    translate([pipe_dx,pipe_y1,pipe_z_long])
    pipe(pipe_length_long, pipe_diam, hole_y1, hole_y2);
    translate([pipe_dx,-pipe_y1,pipe_z_long])
    pipe(pipe_length_long, pipe_diam, hole_y1, hole_y2);
    
    translate([bottom_wood_l-pipe_dx,pipe_y1,pipe_z_long])
    pipe(pipe_length_long, pipe_diam, hole_y1, hole_y2);
    translate([bottom_wood_l-pipe_dx,-pipe_y1,pipe_z_long])
    pipe(pipe_length_long, pipe_diam, hole_y1, hole_y2);

    translate([bottom_wood_l/2,pipe_y1,pipe_z_long])
    pipe(pipe_length_long, pipe_diam, hole_y1, hole_y2);
    translate([bottom_wood_l/2,-pipe_y1,pipe_z_long])
    pipe(pipe_length_long, pipe_diam, hole_y1, hole_y2);
  
    
    /* 
    
    if (!explode) 
    {
        translate([shelf_w/4-4,wood_w/2+gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 

        translate([shelf_w/4-4,-wood_w/2-gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 

        translate([-shelf_w/2+pipe_dx,wood_w/2+gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 

        translate([-shelf_w/2+pipe_dx,-wood_w/2-gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 
    } */
    
    /* brace_w = 4;
    brace_t = 0.3;
    dx = shelf_w - 2 * pipe_dx;
    brace_l = sqrt(pipe_length * pipe_length + dx*dx) - brace_w;
    brace_angle=atan2(pipe_length, dx);
    translate([0,wood_w+gap/2+brace_t/2,pipe_length/2])
    rotate([0,brace_angle,0])
    color([0.23,0.12,0.10, 1.0])
    cube([brace_l, brace_t, brace_w], center=true); */
}        

dividerwall();