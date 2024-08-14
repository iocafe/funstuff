use <wheelbase.scad> 
use <pipe.scad> 

wood_w = 7;
wood_h = 5;
wheel_dist = 45;

hor_bar_diam = 5;
hor_bar_t = 0.4;

support_bar_diam = 2.5;
support_bar_t = 0.3;

module leg_pair(leg_height = 75, extend_up=0, leg_dist = 50, pipe_d = 2.54, right_end=false, explode = false)
{
    wheel_base(leg_dist, wood_w, wood_h, pipe_d);
    
    pipe_len = leg_height - hor_bar_t;
    translate([leg_dist/2,0, 0])
    pipe(pipe_len, pipe_d, 0, 0, explode);
    translate([-leg_dist/2,0, 0])
    pipe(pipe_len+extend_up, pipe_d, 0, 0, explode);
    
    hor_bar_len = leg_dist;
    translate([-hor_bar_len/2, pipe_d/2+hor_bar_t, leg_height])
    rotate([180,0,0])
    anglebar90(hor_bar_len, hor_bar_diam, hor_bar_t);

    support_delta = 40;
    support_hyp = sqrt(2) * support_delta;

    mirror([0,right_end?0:1,0])
    {
        translate([-leg_dist/2-support_bar_t/2, -support_delta-pipe_d/2, pipe_len-support_bar_t])
        rotate([90,45,90])
        anglebar45(support_hyp, support_bar_diam, support_bar_t);

        translate([-leg_dist/2-support_bar_t/2, -support_delta-pipe_d/2, pipe_len])
        rotate([180,0,90])
        anglebar90(support_delta, support_bar_diam, support_bar_t);
    }
}

module anglebar90(length, bar_diam, bar_t)
{
    color([0.8,0.30,0.29, 1.0])
    {
        cube([length, bar_diam, bar_t]);
        cube([length, bar_t, bar_diam]);
    }
}   

module anglebar45(length, bar_diam, bar_t)
{
   color([0.8,0.30,0.29, 1.0])
    {
        linear_extrude(bar_t) 
        polygon(points=[[0,0],
            [bar_diam, bar_diam],
            [length-bar_diam, bar_diam],
            [length, 0], [0,0]]);
 
        cube([length, bar_t, bar_diam]);
    }
}   

/* module wheel_base2(leg_dist = 40, wood_w = 4*2.54, wood_h = 2*2.54, hole_d = 2.54)
{
    translate([0,0,wood_h/2]) color([166/255, 90/255, 23/255, 1]) difference()
    {
        cube([leg_dist+2*wb_dx, wood_w, wood_h], center=true);

        translate([leg_dist/2,0, 0])
        cylinder(d=hole_d,h=wood_h+0.2, center=true, $fn = 33);

        translate([-leg_dist/2,0, 0])
        cylinder(d=hole_d,h=wood_h+0.2, center=true, $fn = 33);
    }
}
*/

leg_pair();