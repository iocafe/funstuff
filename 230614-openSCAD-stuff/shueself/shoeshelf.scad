use <bolt.scad> 
use <pipe.scad> 
use <shelf.scad> 
use <foot.scad> 

module shoeshelf()
{
    shelf_w = 90;
    shelf_h = 100;
    wood_w = 15;    // Coconut wood width
    wood_t = 4.5;     // Coconut wood thickness
    gap = 0.3;      // Gap between wood planks of one shelf
    pipe_dx=8;      // Distance of pipe from end of the self
    pipe_dy=2;
    pipe_diam = 2.0;
    
    pipe_length = shelf_h - wood_w;
    n_shelfs = 4;   // Number of shelfs above bottom shelf
    shelf_y_step = (pipe_length-wood_t)/n_shelfs;
    first_shelf_y = shelf_y_step;
    
    translate([shelf_w/2-pipe_dx,wood_w+gap/2-pipe_dy,0])
    pipe(pipe_length, pipe_diam, first_shelf_y, shelf_y_step, n_shelfs);
    
    translate([-shelf_w/2+pipe_dx,wood_w+gap/2-pipe_dy,0])
    pipe(pipe_length, pipe_diam, first_shelf_y, shelf_y_step, n_shelfs);

    translate([-shelf_w/2+pipe_dx,-wood_w-gap/2+pipe_dy,0])
    pipe(pipe_length, pipe_diam, first_shelf_y, shelf_y_step, n_shelfs);
    
    translate([shelf_w/4-4,-wood_w-gap/2+pipe_dy,0])
    pipe(pipe_length, pipe_diam, first_shelf_y, shelf_y_step, n_shelfs);
    
    shelf(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, true);

    translate([shelf_w/4-4,0,0])
    foot(wood_w, wood_t, gap);

    translate([-shelf_w/2+pipe_dx,0,0])
    foot(wood_w, wood_t, gap);
    
    for (x = [0: n_shelfs-1]) {
        translate([0,0,x * shelf_y_step + first_shelf_y])
        shelf(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, false);
    }
    
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

shoeshelf();