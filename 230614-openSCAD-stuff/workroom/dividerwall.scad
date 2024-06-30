use <bolt.scad> 
use <pipe.scad> 
use <shelf.scad> 
use <foot.scad> 
use <twinwood.scad>
use <twinwoodwithholes.scad>
use <bed/bed.scad> 
use <hdim.scad>

module dividerwall(shelf_w = 330, shelf_h = 210, wood_w = 16,    // Coconut wood width
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.2,// Gimelina wood thickness
    pipe_diam = 2.54,
    fridgebox_depth = 80,
    explode = true)
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
    //bed_angle = 0;
    bed_delta_z = 4;
    bed_delta_y = 3;
    translate([bed_length/2+wood_t+gap_washer,bed_delta_y,bed_height - wood_t/2 - bed_delta_z])
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
    
    bedbox_h = 120;
    bottom_wood_l = shelf_w - fridgebox_depth;
    bedbox_x = bottom_wood_l/2; // + bedbox_length +2*wood_t;
    
    foot_z = explode ? -20 : 0;
    n_feet = 4;
    foot_start = 12;
    foot_span = bottom_wood_l - 2 * foot_start;
    foot_step = foot_span / (n_feet - 1); 
    
    full_shelf_1_h = 29;
    full_shelf_lenth = shelf_w - 2*wood_w - gap;
    full_shelf_1_z = bedbox_h + 2 * wood_t + full_shelf_1_h + (explode?10:0);

    full_shelf_2_h = 39;
    full_shelf_2_z = full_shelf_1_z + wood_t + full_shelf_2_h;
    
    pipe_dx=wood_t/2;      // Distance of pipe from end of the self
    pipe_dy_nomove = 4;
    pipe_dy=explode ? -6 : pipe_dy_nomove;
   
    pipe_length_long = full_shelf_1_h + full_shelf_2_h + 3 * wood_t;
    pipe_length_nomove = pipe_length_long + 12;
    
    pipe_z_long = bedbox_h + wood_t + (explode?10:0);
    pipe_z_nomove = pipe_z_long - 1;
    pipe_y1 = wood_w + gap/2 - pipe_dy;
    pipe_y1_nomove = wood_w + gap/2 - pipe_dy_nomove;
    hole_y1 = full_shelf_1_h + wood_t - 0.5;
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

    difference () {
    union() {
        bedbox_top_wood_l = bedbox_length + 2 * wood_t;
        translate([bedbox_x,0,bedbox_h + wood_t + (explode?10:0)])
        twinwood(bottom_wood_l, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

        translate([full_shelf_lenth/2,0,full_shelf_1_z])
        twinwood(full_shelf_lenth, wood_w, wood_t, gap, 3 /*n_braces*/, explode);

        translate([full_shelf_lenth/2,0,full_shelf_2_z])
        twinwood(full_shelf_lenth, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
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
    
    translate([0,pipe_y1,pipe_z_long])
    rotate([0,-90,-90])
    hdim(0, pipe_length_long, 0, 10.0);
}        

dividerwall();