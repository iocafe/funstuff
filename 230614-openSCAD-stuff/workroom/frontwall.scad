use <bolt.scad> 
use <pipe.scad> 
use <shelf.scad> 
use <foot.scad> 
use <twinwood.scad>
use <basicdoor.scad> 


module frontwall(shelf_w = 270, 
    shelf_h = 210, 
    wood_w = 15,    // Coconut wood width
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.2,// Gimelina wood thickness
    pipe_diam = 2.54,
    fridgebox_width = 70,
    explode = false)
{    
    gap = 0.3;
    door_x1 = 120;
    door_x2 = 200;

    // Copy from dividerwall.scad
    full_shelf_1_h = 29;
    full_shelf_2_h = 39;
    bedbox_h = 120;

    bottom_wood_1_l = door_x1 - fridgebox_width;
    translate([fridgebox_width+bottom_wood_1_l/2,0,0])
    twinwood(bottom_wood_1_l, wood_w, wood_t, gap, 2 /*n_braces*/, explode);

    bottom_wood_2_l = shelf_w - door_x2;
    translate([door_x2+bottom_wood_2_l/2,0,0])
    twinwood(bottom_wood_2_l, wood_w, wood_t, gap, 2 /*n_braces*/, explode);
    
    foot_d = 10;
    foot_z = explode ? -20 : 0;
    translate([fridgebox_width+foot_d,0,foot_z])
    foot(wood_w, gim_t, gap);
    translate([door_x1-foot_d,0,foot_z])
    foot(wood_w, gim_t, gap);
    translate([door_x2+foot_d,0,foot_z])
    foot(wood_w, gim_t, gap);
    translate([shelf_w-foot_d,0,foot_z])
    foot(wood_w, gim_t, gap);
    
    shelf_a_z = full_shelf_1_h + bedbox_h + wood_t;
    translate([fridgebox_width+wood_t,0,shelf_a_z/2 + wood_t])
    rotate([0,270,0])
    twinwood(shelf_a_z, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

    shelf_b_z = shelf_a_z + wood_t + full_shelf_2_h;

    translate([fridgebox_width+bottom_wood_1_l,0,shelf_b_z/2 + wood_t])
    rotate([0,270,0])
    twinwood(shelf_b_z, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

    translate([door_x2+wood_t,0,shelf_b_z/2 + wood_t])
    rotate([0,270,0])
    twinwood(shelf_b_z, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

    translate([shelf_w,0,shelf_b_z/2 + wood_t])
    rotate([0,270,0])
    twinwood(shelf_b_z, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

    mid_wood_l = door_x1 - wood_t;
    translate([mid_wood_l/2,0,shelf_a_z+wood_t])
    twinwood(mid_wood_l, wood_w, wood_t, gap, 2 /*n_braces*/, explode);

    translate([shelf_w/2,0,shelf_h-2*wood_t])
    twinwood(shelf_w, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
    
    
    pipe_dx=wood_t/2;      // Distance of pipe from end of the self
    pipe_dy=4;
    pipe_length_short = full_shelf_2_h + 2 * wood_t;
    pipe_z_short = shelf_a_z+wood_t;
    pipe_y1 = wood_w + gap/2 - pipe_dy;
    hole_y1 = full_shelf_1_h + wood_t - 0.5;
    hole_y2 = hole_y1 + full_shelf_2_h + wood_t;
    
    translate([pipe_dx,pipe_y1,pipe_z_short])
    pipe(pipe_length_short, pipe_diam, hole_y1, hole_y2);
    translate([pipe_y1*2+pipe_dx,-pipe_y1,pipe_z_short])
    pipe(pipe_length_short, pipe_diam, hole_y1, hole_y2);


    
/*
    rotate([0,0,270])
    {
        translate([0,0,gim_t])
        // frontwall2(shelf_w, shelf_h, wood_w, wood_t, gim_t, fridgebox_width, explode);
        
}   */ 
       /* Door between kitchen and work room */
   /*     translate([(door_x1+door_x2)/2,wood_w/2,0])
          basicdoor(door_x2-door_x1, 207.2, wood_w, true, 30); 
 
   */
}

module frontwall2(shelf_w = 330, 
    shelf_h = 210, 
    wood_w = 15,    // Coconut wood width 
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.2,     // Gimelina wood thickness
    fridgebox_width = 80,
    explode = false)
{
    gap = 0.3;      // Gap between wood planks of one shelf
   
    bottom_wood_l = shelf_w - fridgebox_width;
    bedbox_x = bottom_wood_l/2; // + bedbox_length +2*wood_t;
    translate([bedbox_x + 0,0,0])
    twinwood(bottom_wood_l, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
    
    bedbox_h = 120;
    translate([111+2*wood_t,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwood(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
    translate([wood_t,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwood(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

    translate([bottom_wood_l,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwood(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
   
    /* foot_z = explode ? -20 : 0;
    n_feet = 4;
    foot_start = 12;
    foot_span = bottom_wood_l - 2 * foot_start;
    foot_step = foot_span / (n_feet - 1); 
    for (foot_i = [0:n_feet-1]) {
        translate([111-foot_span/2+foot_i * foot_step,0,foot_z])
        foot(wood_w, gim_t, gap);
    } */

    /* full_shelf_1_h = 29;
    full_shelf_1_y = bedbox_h + 2 * wood_t + full_shelf_1_h;
    translate([shelf_w/2,0,full_shelf_1_y])
    twinwood(shelf_w, wood_w, wood_t, gap, 3, explode);
    
    full_shelf_2_h = 39;
    full_shelf_2_y = full_shelf_1_y + wood_t + full_shelf_2_h;
    translate([shelf_w/2,0,full_shelf_2_y])
    twinwood(shelf_w, wood_w, wood_t, gap, 3, explode);
 */
 /*   pipe_dx=wood_t/2;      // Distance of pipe from end of the self
    pipe_dy=4;
    pipe_diam = 2.54;
    
    pipe_length_long = full_shelf_1_h + full_shelf_2_h + 3 * wood_t;
    //pipe_length_short = full_shelf_2_h + 3 * wood_t;
    
    pipe_z_long = 100 + wood_t;
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
  */
    
  
}        

frontwall();