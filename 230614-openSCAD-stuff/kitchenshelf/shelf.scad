use <hdim.scad> 
use <bolt.scad> 

bighole_diam = 5.0;
bighole_delta = 12.0;
bolt_hole_diam = 1.3;

// end: 1 = pipe hole, 2 = big hole, 3 = bolt hole

module shelf(shelf_w = 90, wood_w = 15, wood_t = 5, gap = 0.3, pipe_dx=8, pipe_dy=3, pipe_diam = 2.54, left_end=1, right_end=3, bolt_down = 6, bolt_up=20, explode=false)
{
    wood_y = wood_w/2+gap/2 + (explode ? 10 : 0);
    translate([0, wood_y, wood_t/2])
        onewood(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, false, left_end, right_end, bolt_down, bolt_up, explode);

    translate([0, -wood_y, wood_t/2])
        onewood(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, true, left_end, right_end, bolt_down, bolt_up, explode);

    brace_z = explode ? -7 : 0;

    translate([shelf_w/4+2, 0, brace_z]) 
    ironbrace(2*wood_w+gap);
    
    translate([-shelf_w/4-2, 0, brace_z]) 
    ironbrace(2*wood_w+gap);
}        

module onewood(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, is_front, left_end, right_end, bolt_down, bolt_up, explode)
{
    hole_y = is_front ? -wood_w/2+pipe_dy : wood_w/2-pipe_dy;
    hole_x = shelf_w/2-pipe_dx;
    difference()
    {
        color([0.75,0.48,0.19, 1.0])
        cube([shelf_w, wood_w, wood_t], center=true);
    
        if (right_end == 1) { // pipe hole
            translate([hole_x, hole_y,0])
            cylinder(h=wood_t+0.5,r=pipe_diam/2,center = true, $fn = 16);
        } else {
            if (right_end == 3) { // bolt hole
                translate([hole_x, 0,0])
                cylinder(h=wood_t+0.5,d=bolt_hole_diam,center = true, $fn = 16);
            }
            else { // big gole
                translate([shelf_w/2 + wood_t - bighole_delta,0,0])
                cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);
            }
        }

        if (left_end == 1) {
            translate([-hole_x, hole_y,0])
            cylinder(h=wood_t+0.5,r=pipe_diam/2,center = true, $fn = 16);
        } else {
            translate([-shelf_w/2 - wood_t + bighole_delta,0,0])
            cylinder(h=wood_t+0.2,r=bighole_diam/2,center = true, $fn = 16);
        }
    }
    
    if (bolt_down != 0) {
        translate([bolt_down, 0, wood_t/2])
        rotate([0, 90, 0])
        bolt(0);
    }

    if (bolt_up != 0) {
        translate([bolt_up, 0, -wood_t/2])
        rotate([0, -90, 0])
        bolt(0);
    }
    
    if (right_end == 3 && !explode) {
    translate([hole_x,0,wood_t/2])
        rotate([0,90,0]) bolt(0);
    } 
}   

module ironbrace(shelf_depth)
{
    brace_w = 4;
    brace_t = 0.3;
    brace_d1 = 4;
    brace_d2 = 1;
    n_screw_holes = 4;
    brace_l = shelf_depth - brace_d1 - brace_d2;
    screw_range = brace_l - 3;
    screw_step = screw_range/(n_screw_holes-1);
    first_screw = -screw_range/2;
    screw_hole_diam = 0.6;

    translate([0,(brace_d1-brace_d2)/2,-brace_t/2]) difference()
    {
        color([0.23,0.12,0.10, 1.0])
        cube([brace_w, brace_l, brace_t], center=true);
        
        for (x = [0: n_screw_holes-1]) {
            translate([0,x * screw_step + first_screw, 0])
            cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
        }
    }
}

shelf();