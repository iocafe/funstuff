use <bolt.scad> 
use <pipe.scad> 
use <shelf.scad> 
use <foot.scad> 
use <waterdispenser.scad>

module kitcenshelf()
{
    water_at_right = true;
    explode = false;
    shelf_w = 182;
    shelf_h = 125;
    wood_w = 17;    // Coconut wood width
    wood_t = 4.5;     // Coconut wood thickness
    gap = 0.5;      // Gap between wood planks of one shelf
    pipe_dx=6;      // Distance of pipe from end of the self
    pipe_dy=3;
    pipe_diam = 2.54;
    
    pipe_length = shelf_h - wood_w;
    n_shelfs = 4;   // Number of shelfs above bottom shelf
    shelf_pos =  water_at_right ? [20,52,73,shelf_h - wood_w - wood_t] : [26,52,80,shelf_h - wood_w - wood_t];
    shelf_cut = water_at_right ? [2,0,3,3] : [0,2,1,1];
    shelf_y_step = (pipe_length-wood_t)/n_shelfs;
    first_shelf_y = shelf_y_step;
    hole_pos_y = first_shelf_y - 0.5; 
    pipe_y = wood_w+gap/2-pipe_dy + (explode ? 40 : 0);
    
    dx = shelf_w/2-pipe_dx;
    dx2 = dx/3 + (water_at_right ? 0 : 6.5);
    right_pipe_l = water_at_right ? (shelf_pos[1] + wood_t): pipe_length;
    
    translate([dx,pipe_y,-0.01])
    pipe(right_pipe_l+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);

    translate([dx2,pipe_y,-0.01])
    pipe(pipe_length+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);
    
    translate([-dx2,pipe_y,-0.01])
    pipe(pipe_length+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);
    
    translate([-dx,pipe_y,-0.01])
    pipe(pipe_length+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);

    translate([-dx,-pipe_y,-0.01])
    pipe(pipe_length+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);

    translate([dx2,-pipe_y,-0.01])
    pipe(pipe_length+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);

    translate([-dx2,-pipe_y,-0.01])
    pipe(pipe_length+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);
    
    translate([dx,-pipe_y,-0.01])
    pipe(right_pipe_l+0.02, pipe_diam, hole_pos_y, shelf_y_step, n_shelfs);
    
    shelf(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, true, explode);
    
    foot_z = explode ? -20 : 0;

    translate([dx,0,foot_z])
    foot(wood_w, wood_t, gap);

    translate([0,0,foot_z])
    foot(wood_w, wood_t, gap);

    translate([-dx,0,foot_z])
    foot(wood_w, wood_t, gap);
    
    for (x = [0: n_shelfs-1]) {
        zpos = shelf_pos[x];
        translate([0,0,zpos]) {
            if (shelf_cut[x] == 1) {
                ww = dx - dx2 + 2*pipe_dx;
                translate([shelf_w/2-ww/2,0,0])
                shelf(ww, wood_w, wood_t, 
                    gap, pipe_dx, pipe_dy, pipe_diam, false, explode);
                translate([-shelf_w/2+ww/2,0,0])
                shelf(ww, wood_w, wood_t, 
                    gap, pipe_dx, pipe_dy, pipe_diam, false, explode);
            }
            else {
                if (shelf_cut[x] == 2) {
                    ww2 = shelf_w - dx + dx2;
                    translate([+shelf_w/2-ww2/2,0,0])
                    shelf(ww2, wood_w, wood_t, 
                        gap, pipe_dx, pipe_dy, pipe_diam, false, explode);
                }
                else {
                    if (shelf_cut[x] == 3) {
                        ww2 = shelf_w - dx + dx2;
                        translate([-shelf_w/2+ww2/2,0,0])
                        shelf(ww2, wood_w, wood_t, 
                            gap, pipe_dx, pipe_dy, 
                            pipe_diam, false, explode);
                    }
                    else {
                        shelf(shelf_w, wood_w, wood_t, 
                        gap, pipe_dx, pipe_dy, pipe_diam, false, explode);
                    }
                }
            }
        }
    }
    
    if (!explode) 
    {
        translate([dx,wood_w/2+gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 

        translate([dx,-wood_w/2-gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 

        translate([-dx,wood_w/2+gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 

        translate([-dx,-wood_w/2-gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 
        
        translate([0,wood_w/2+gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 

        translate([0,-wood_w/2-gap/4, wood_t+0.3])
        rotate([0,90,0])
        bolt(0, wood_t); 
        
        if (water_at_right) {
            cx = (shelf_w/2 + dx2)/2;
            translate([cx-13,0, 56.5])
            waterdispenser();    
            translate([cx+17,0, 56.5])
            waterdispenser();    
        }
        else {
            translate([-15,0, 56.5])
            waterdispenser();    
            translate([15,0, 56.5])
            waterdispenser();    
        }
    }
    
}        

kitcenshelf();