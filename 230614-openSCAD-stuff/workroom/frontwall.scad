use <bolt.scad> 
use <pipe.scad> 
use <twoboltholes.scad> 
use <foot.scad> 
use <twinwood.scad>
use <twinwoodwithholes.scad>
use <basicdoor.scad> 
use <hdim.scad> 

module frontwall(shelf_w = 270, 
    wood_w = 16,    // Coconut wood width
    wood_t = 4.5,     // Coconut wood thickness
    gim_t = 4.2,// Gimelina wood thickness
    pipe_diam = 2.54,
    fridgebox_width = 70,
    explode = true)
{    
    gap = 0.3;
    door_x1 = 120;
    door_x2 = 200;

    // Copy from dividerwall.scad
    full_shelf_1_h = 29;
    full_shelf_2_h = 39;
    bedbox_h = 125;

    bottom_wood_1_l = door_x1 - fridgebox_width;
    translate([fridgebox_width+bottom_wood_1_l/2,0,explode?-10:0])
    twinwood(bottom_wood_1_l, wood_w, wood_t, gap, 2 /*n_braces*/, explode);

    bottom_wood_2_l = shelf_w - door_x2;
    translate([door_x2+bottom_wood_2_l/2,0,explode?-10:0])
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
    shelf_a_zz = shelf_a_z + (explode?10:0);
    
    translate([fridgebox_width+wood_t,0,shelf_a_z/2 + wood_t])
    rotate([0,270,0])
    twinwoodwithholes(shelf_a_z, wood_w, wood_t, gap, 3 /*n_braces*/, true, true, explode);

    shelf_b_z = shelf_a_z + wood_t + full_shelf_2_h;
    shelf_b_zz = shelf_b_z + (explode?20:0);
    
    translate([fridgebox_width+bottom_wood_1_l-wood_t,0,shelf_b_z/2 + wood_t])
    rotate([0,270,180])
    twinwoodwithholes(shelf_b_z, wood_w, wood_t, gap, 3 /*n_braces*/, true, true, explode);

    translate([door_x2+wood_t,0,shelf_b_z/2 + wood_t])
    rotate([0,270,0])
    twinwoodwithholes(shelf_b_z, wood_w, wood_t, gap, 3 /*n_braces*/, true, true, explode);

    translate([shelf_w,0,shelf_b_z/2 + wood_t])
    rotate([0,270,0])
    twinwoodwithholes(shelf_b_z, wood_w, wood_t, gap, 3 /*n_braces*/, true, true, explode, true);

    mid_wood_l = door_x1 - wood_t;
    translate([mid_wood_l/2-(explode?10:0),0,shelf_a_zz+wood_t])
    twinwoodwithholes(mid_wood_l, wood_w, wood_t, gap, 2 /*n_braces*/, true, false, explode);

    difference() {
        translate([shelf_w/2,0,shelf_b_zz+wood_t]) 
        twinwood(shelf_w, wood_w, wood_t, gap, 3 /*n_braces*/, explode);
        translate([door_x1-wood_t/2,0,shelf_b_zz+1.5*wood_t]) 
        twoboltholes(wood_w, gap);
        translate([door_x2+wood_t/2,0,shelf_b_zz+1.5*wood_t]) 
        twoboltholes(wood_w, gap);
        translate([shelf_w - wood_t/2,0,shelf_b_zz+1.5*wood_t]) 
        twoboltholes(wood_w, gap);
    }
    translate([shelf_w - wood_t/2,-wood_w/2,shelf_b_zz+2.0*wood_t]) 
    hdim(0, wood_t/2, 0, 9);
    translate([door_x2 + wood_t/2,-wood_w/2,shelf_b_zz+2.0*wood_t]) 
    hdim(0, shelf_w - door_x2 - wood_t, 0, 5);
    translate([0,-wood_w/2,shelf_b_zz+2.0*wood_t]) 
    hdim(0, door_x1 - wood_t/2, 0, 12);
    translate([door_x1,-wood_w/2,shelf_b_zz+2.0*wood_t]) 
    rotate([0,0,90])
    hdim(0, wood_w + gap/2, 0, 5);
    
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
}

frontwall();