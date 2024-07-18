use <bolt.scad> 
use <pipe.scad> 
use <foot.scad> 
use <twinwood.scad>
use <twinwoodwithholes.scad>
use <bed/bed.scad> 
use <hdim.scad>
use <shelfplaywood.scad>

show_shelf_playwood = false;
shelf_playwood_thickness = 0.75 * 2.54;
computer_room_length = 325;
fridge_depth = 57;
fridge_back_gap = 7;

module dividerwall(shelf_w = computer_room_length, 
    wood_w = 17,      // Coconut wood width
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.5,      // Gimelina wood thickness
    pipe_diam = 2.54,
    fridgebox_depth = fridge_depth + fridge_back_gap,
    explode = false)
{
    bed_height = 35.5;
    gap_washer = 1.5;
    matress_length = 190.3;
    matress_width = 94;
    bed_length = matress_length + 2*wood_t;
    
    translate([0,0,gim_t])
    dividerwall2(shelf_w, bed_length+2*gap_washer, wood_w, wood_t, gim_t, pipe_diam, fridgebox_depth, explode);
    
    bed_angle = ($t > 0.5) ? (180 - 180 * $t) : (180 * $t);
    //bed_angle = 0;
    bed_delta_z = 3.0;
    //bed_delta_y = 3;
    bed_delta_y = -4.3;
    translate([bed_length/2+wood_t+gap_washer,bed_delta_y,bed_height - wood_t/2 - bed_delta_z])
    rotate([bed_angle,0,0])
    coconutbed(matress_length, matress_width, wood_w, wood_t, pipe_diam, gap_washer, bed_height, explode);
}

module dividerwall2(shelf_w = 330, 
    bedbox_length = 225, 
    wood_w = 17,    // Coconut wood width
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.5,     // Gimelina wood thickness
    pipe_diam = 2.54,
    fridgebox_depth = 80,
    explode = false)
{
    gap = 0.3;      // Gap between wood planks of one shelf
    
    bedbox_h = 125;
    bottom_wood_l = shelf_w - fridgebox_depth;
    bedbox_x = bottom_wood_l/2; // + bedbox_length +2*wood_t;
    
    foot_z = explode ? -20 : 0;
    n_feet = 4;
    foot_start = 12;
    foot_span = bottom_wood_l - 2 * foot_start;
    foot_step = foot_span / (n_feet - 1); 
    
    full_shelf_1_h = 29;
    full_shelf_length = shelf_w - 2*wood_w - gap;
    full_shelf_1_z = bedbox_h + 2 * wood_t + full_shelf_1_h + (explode?10:0);

    full_shelf_2_h = 39;
    full_shelf_2_z = full_shelf_1_z + wood_t + full_shelf_2_h;
    
    pipe_dx=5;      
    pipe_dy_nomove = 4;
    pipe_dy=explode ? -6 : pipe_dy_nomove;
   
    pipe_length_long = full_shelf_1_h + full_shelf_2_h + 3 * wood_t;
    pipe_length_nomove = pipe_length_long + 12;
    
    pipe_z_long = bedbox_h + wood_t + (explode?10:0);
    pipe_z_nomove = pipe_z_long - 1;
    pipe_y1 = wood_w + gap/2 - pipe_dy;
    pipe_y1_nomove = wood_w + gap/2 - pipe_dy_nomove;
    hole_y1 = full_shelf_1_h + wood_t - 0.8;
    hole_y2 = hole_y1 + full_shelf_2_h + wood_t;
    
    translate([bedbox_x + 0,0,explode?-10:0])
    twinwood(bottom_wood_l, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
  
    translate([bedbox_length+2*wood_t,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwoodwithholes(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, true, true, explode);
    translate([wood_t,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwoodwithholes(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, true, true, explode);

    translate([bottom_wood_l,0,bedbox_h/2 + wood_t])
    rotate([0,270,0])
    twinwoodwithholes(bedbox_h, wood_w, wood_t, gap, 3 /*n_braces*/, true, true, explode);
   

    for (foot_i = [0:n_feet-1]) {
        translate([bedbox_x-foot_span/2+foot_i * foot_step,0,foot_z])
        foot(wood_w, gim_t, gap);
    }

translate([1.5*wood_t,0,0]) hdim(bedbox_length, bottom_wood_l-2*wood_t, -5, 5);

    difference () {
    union() {
        bedbox_top_wood_l = bedbox_length + 2 * wood_t;
        translate([bedbox_x,0,bedbox_h + wood_t + (explode?10:0)])
        twinwood(bottom_wood_l, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

        translate([full_shelf_length/2,0,full_shelf_1_z])
        twinwood(full_shelf_length, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

        translate([full_shelf_length/2,0,full_shelf_2_z])
        twinwood(full_shelf_length, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
    } 
    
    union() {
        translate([pipe_dx,pipe_y1_nomove,pipe_z_nomove])
        pipe(pipe_length_nomove, pipe_diam, 0, 0);
        translate([pipe_dx,-pipe_y1_nomove,pipe_z_nomove])
        pipe(pipe_length_nomove, pipe_diam, 0, 0);
        
        translate([bottom_wood_l-pipe_dx,pipe_y1_nomove,pipe_z_nomove])
        pipe(pipe_length_nomove, pipe_diam, 0, 0);
        translate([bottom_wood_l-pipe_dx,-pipe_y1_nomove,pipe_z_nomove])
        pipe(pipe_length_nomove, pipe_diam, 0, 0);

        translate([bottom_wood_l/2,pipe_y1_nomove,pipe_z_nomove])
        pipe(pipe_length_nomove, pipe_diam, 0, 0);
        translate([bottom_wood_l/2,-pipe_y1_nomove,pipe_z_nomove])
        pipe(pipe_length_nomove, pipe_diam, 0, 0);
    }
    }
    
    translate([60,-wood_w-gap/2,full_shelf_2_z+wood_t])
    rotate([0,90,90])
    hdim(0, full_shelf_2_z-full_shelf_1_z, 0, 5.0);
  
    translate([80,-wood_w-gap/2,full_shelf_1_z+wood_t])
    rotate([0,90,90])
    hdim(0, full_shelf_1_z-bedbox_h-wood_t, 0, 5.0);
  
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
    pipe(pipe_length_long, pipe_diam, hole_y1, hole_y2, true);
    
    translate([0,pipe_y1,pipe_z_long])
    rotate([0,-90,-90])
    hdim(0, pipe_length_long, 0, 10.0);

    translate([0,-pipe_y1,full_shelf_2_z+wood_t])
    hdim(0, (bottom_wood_l)/2, 0, -5.0);

    translate([0,-pipe_y1,full_shelf_2_z+wood_t])
    hdim(0, bottom_wood_l-pipe_dx, 0, -10.0);

    translate([0,-pipe_y1,full_shelf_2_z+wood_t])
    hdim(0, pipe_dx, 0, 5.0);
   
    translate([pipe_dx,0,full_shelf_2_z+1])
    rotate([0,0,-90])
    hdim(-pipe_y1, pipe_y1, 0, 5.0); 
    
    if (show_shelf_playwood)
    {
        translate([bottom_wood_l/2, -wood_w-gap/2-shelf_playwood_thickness,0])
        shelfplaywood(bottom_wood_l, bedbox_h + 2*wood_t, shelf_playwood_thickness);

        translate([bottom_wood_l/2, wood_w+gap/2,bedbox_h + wood_t])
        shelfplaywood(bottom_wood_l, full_shelf_2_z - bedbox_h , shelf_playwood_thickness);

        small_piece_w = full_shelf_length - bottom_wood_l +2 * wood_w+gap + shelf_playwood_thickness;
        translate([bottom_wood_l+small_piece_w/2, wood_w+gap/2,full_shelf_1_z])
        shelfplaywood(small_piece_w, full_shelf_2_z - full_shelf_1_z + wood_t, shelf_playwood_thickness);
    }
    
    translate([0,-wood_w-gap/2,25.1])
    rotate([-90,0,90])
    hdim(0, 12.8, 0, 5.0); 
    
    translate([0,-4.4,wood_t])
    rotate([0,-90,0])
    hdim(0, 20.6, 0, 5.0); 
}        

dividerwall();