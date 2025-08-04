use <ceiling-anglebars.scad> 

default_bar_diam = 3.8;
default_bar_t  = 0.3;

module bedroom_ceiling(length = 330, width = 240, 
    bar_diam = default_bar_diam, 
    bar_t = default_bar_t, 
    explode=false, 
    explode_d = 20, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0])
{
    d = explode ? explode_d : 0;
    
    pillar_intrude = 5;
    cut_angle = 22.5;
    cut_l = 2 * pillar_intrude;
    l = length - 2*cut_l;
    w = width - 2*cut_l;
    diag_l = 1.41421356237 * cut_l;
       
    translate([-l/2,-width/2-d,0]) 
    ceiling_corner_anglebar(l, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);

    translate([0,width/2+d,0]) 
    rotate([0,0,180]) 
    translate([-l/2,0,0]) 
    ceiling_corner_anglebar(l, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);
       
    translate([length/2+d,0,0]) 
    rotate([0,0,90]) 
    translate([-w/2,0,0]) 
    ceiling_corner_anglebar(w, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);

    translate([-length/2-d,0,0]) 
    rotate([0,0,-90]) 
    translate([-w/2,0,0]) 
    ceiling_corner_anglebar(w, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);

    translate([-length/2+cut_l/2-d,
        -width/2+cut_l/2-d,0]) 
    rotate([0,0,-45]) 
    translate([-diag_l/2,0,0]) 
    ceiling_corner_anglebar(diag_l, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);

    translate([-length/2+cut_l/2-d,
        width/2-cut_l/2+d,0]) 
    rotate([0,0,-135]) 
    translate([-diag_l/2,0,0]) 
    ceiling_corner_anglebar(diag_l, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);

    translate([length/2-cut_l/2+d,
        -width/2+cut_l/2-d,0]) 
    rotate([0,0,45]) 
    translate([-diag_l/2,0,0]) 
    ceiling_corner_anglebar(diag_l, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);

    translate([length/2-cut_l/2+d,
        width/2-cut_l/2+d,0]) 
    rotate([0,0,135]) 
    translate([-diag_l/2,0,0]) 
    ceiling_corner_anglebar(diag_l, 
        cut_angle, cut_angle, 
        bar_diam, bar_t, c2);
}        



bedroom_ceiling(explode=false);