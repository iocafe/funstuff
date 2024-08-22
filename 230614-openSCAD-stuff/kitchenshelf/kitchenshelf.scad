use <bolt.scad> 
use <pipe.scad> 
use <shelf.scad> 
use <legcup.scad> 
use <waterdispenser.scad>
use <verticalwood.scad>
use <hdim.scad>

module kitcenshelf()
{
    water_at_right = true;
    explode = true;
    shelf_w = 182;
    shelf_h = 125;
    leg = 10;
    wood_w = 12*2.54/2; // Coconut wood width
    wood_t = 4.3;       // Coconut wood thickness
    gap = 0.0;          // Gap between wood planks of one shelf
    pipe_dx=5;          // Distance of pipe from end of the self
    pipe_dy=4;
    pipe_diam = 3.3; // 2.54;
    
    pipe_length = shelf_h;
    short_pipe_length = shelf_h - leg;
    n_shelfs = 4;   // Number of shelfs above bottom shelf
    shelf_pos = [22,53,75,shelf_h - leg - wood_t];
    shelf_cut = [2,0,4,3];
    shelf_y_step = (pipe_length-wood_t)/n_shelfs;
    first_shelf_y = shelf_y_step;
    pipe_y = wood_w+gap/2-pipe_dy + (explode ? 40 : 0);
    pipe_z = -leg;
    
    dx = shelf_w/2-pipe_dx;
    dx2 = dx/3;
    right_pipe_l = (shelf_pos[1] + leg + wood_t);
    
    bolt_down = [0, -dx2, 0, 0];
    bolt_up = [0, dx2, 0, 0];
    
    pipe_bolt_carry_r = 0.65; // Radius of stopper end bolt hex end
    start_a = leg - pipe_bolt_carry_r;
    pipe_hole_a = [start_a, 
        start_a + shelf_pos[1], 
        start_a + shelf_pos[2],
        start_a + shelf_pos[3]];
    n_holes_a = 4;

    pipe_hole_b = [start_a, 
        start_a + shelf_pos[0], 
        start_a + shelf_pos[1]];
    n_holes_b = 3;
   
    translate([dx,pipe_y,pipe_z-0.01]) {
        pipe(right_pipe_l+0.02, pipe_diam, 
            pipe_hole_b, n_holes_b);
        legcup();
    }
   
    translate([-dx2,0,wood_t])
    verticalpair(shelf_pos[1]-wood_t, wood_w, wood_t, gap, 0, shelf_pos[0]-wood_t/2);
    
    translate([dx2,0,shelf_pos[1]+wood_t])
    verticalpair(shelf_pos[3]-shelf_pos[1]-wood_t, wood_w, wood_t, gap, shelf_pos[2]-shelf_pos[1]-wood_t/2, 0);
    
    translate([-dx,pipe_y,pipe_z-0.01]) {
        pipe(pipe_length+0.02, pipe_diam, 
            pipe_hole_a, n_holes_a);
        legcup();
    }

    translate([-dx,-pipe_y,pipe_z-0.01]) {
        pipe(pipe_length+0.02, pipe_diam, 
            pipe_hole_a, n_holes_a);
        legcup();
    }

    translate([dx,-pipe_y,pipe_z-0.01]) {
        pipe(right_pipe_l+0.02, pipe_diam, 
            pipe_hole_b, n_holes_b);
        legcup();
    }
    
    shelf(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, 1,1, 0, -dx2, explode);
    
    foot_z = explode ? -20 : 0;

   
    for (x = [0: n_shelfs-1]) {
        zpos = shelf_pos[x];
        translate([0,0,zpos]) {
            if (shelf_cut[x] == 2) {
                ww2 = shelf_w/2 + dx2 - wood_t/2;
                translate([+shelf_w/2-ww2/2,0,0])
                shelf(ww2, wood_w, wood_t, 
                    gap, pipe_dx, pipe_dy, pipe_diam, 
                        2, 1, bolt_down[x], bolt_up[x], explode);
            }
            else {
                if (shelf_cut[x] >= 3) {
                    ww2 = shelf_cut[x]==3 ? shelf_w - dx + dx2 : shelf_w/2 + dx2 - wood_t/2;
                    translate([-shelf_w/2+ww2/2,0,0])
                    shelf(ww2, wood_w, wood_t, 
                        gap, pipe_dx, pipe_dy, 
                        pipe_diam, 1, shelf_cut[x]==3 ? 3 : 2, 
                        bolt_down[x], bolt_up[x], explode);
                }
                else {
                    shelf(shelf_w, wood_w, wood_t, 
                    gap, pipe_dx, pipe_dy, pipe_diam, 
                        1, 1, bolt_down[x], bolt_up[x], explode);
                }
            }
        }
    }
    
    
    // Top shelf bolt position
    translate([0, -wood_w/2, shelf_pos[n_shelfs-1]+wood_t])
    hdim(dx2, shelf_w/2 -dx + dx2, 0, 3);
    translate([dx2, 0, shelf_pos[n_shelfs-1]+wood_t])
    rotate([0,0,90])
    hdim(-wood_w/2, wood_w/2, 0, 3);

    // Top shelf pipe hole position
    translate([-shelf_w/2, -wood_w+pipe_dy, shelf_pos[n_shelfs-1]+wood_t])
    hdim(0, pipe_dx, 0, 9);
    translate([-shelf_w/2+pipe_dx, 0, shelf_pos[n_shelfs-1]+wood_t])
    rotate([0,0,90])
    hdim(-wood_w+pipe_dy, wood_w-pipe_dy, 0, 3);
    
    if (!explode) 
    {
        if (water_at_right) {
            cx = (shelf_w/2 + dx2)/2;
            translate([cx-13,0, 57.5])
            waterdispenser();    
            translate([cx+17,0, 56.5])
            waterdispenser();    
        }
        else {
            translate([-15,0, 57.5])
            waterdispenser();    
            translate([15,0, 56.5])
            waterdispenser();    
        }
    }
    
}        

kitcenshelf();