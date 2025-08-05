use <ceiling-anglebars.scad> 

big_bar_diam = 1.5 * 2.54;
big_bar_t = 0.3;
small_bar_diam = 1.0 * 2.54;
small_bar_t = 0.3;

bedroom_w = 245.5;
bedroom_l = 296.5;

module bedroom_ceiling_corners(
    length = bedroom_l, 
    width = bedroom_w, 
    bar_diam = big_bar_diam, 
    bar_t = big_bar_t, 
    explode = false, 
    explode_d = 20, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0])
{
    d = explode ? 2.0*explode_d : 0;
    
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

module ceiling_grid(length = bedroom_l, 
    width = bedroom_w,
    fix_diam = big_bar_diam,
    fix_t = big_bar_t,
    bar_diam = big_bar_diam, 
    bar_t = big_bar_t, 
    explode = false, 
    explode_d = 20, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0],
    c3 = [0.5,0.58,0.19, 1.0], 
    c4 = [0.8,0.50,0.29, 1.0]) 
{
    dx = explode ? 0.70*explode_d : 0;
    dy = explode ? 0.70*explode_d : 0;
    dx2 = explode ? 1.3*explode_d : 0;
    dy2 = explode ? 1.3*explode_d : 0;
    small_fix_diam = small_bar_diam;
    small_fix_t = small_bar_t;

    translate([-length/2,0,0])
    ceiling_t_bar(length, 
        fix_diam, fix_t,
        fix_diam, fix_t,
        bar_diam, bar_t,
        c1);

    translate([0, width/2+dy,0])
    rotate([0,0,90])
    translate([-width/2,0,0])
    ceiling_t_bar(width/2, 
        fix_diam, fix_t,
        fix_diam, fix_t,
        bar_diam, bar_t,
        c2);

    translate([0,-dy,0])
    rotate([0,0,90])
    translate([-width/2,0,0])
    ceiling_t_bar(width/2, 
        fix_diam, fix_t,
        fix_diam, fix_t,
        bar_diam, bar_t,
        c2);

    translate([-length/2-dx,width/4+dy,0])
    ceiling_t_bar(length/2, 
        fix_diam, fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c1);

    translate([-length/2-dx,-width/4-dy,0])
    ceiling_t_bar(length/2, 
        fix_diam, fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c1);

    translate([dx,width/4+dy,0])
    ceiling_t_bar(length/2, 
        fix_diam, fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c1);

    translate([dx,-width/4-dy,0])
    ceiling_t_bar(length/2, 
        fix_diam, fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c1);

    translate([length/4+dx,-dy/2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        fix_diam, fix_t,
        small_fix_diam, small_fix_t,
        small_bar_diam, small_bar_t,
        c2);

    translate([-length/4-dx, -dy/2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        fix_diam, fix_t,
        small_fix_diam, small_fix_t,
        small_bar_diam, small_bar_t,
        c2);

    translate([length/4+dx, width/2+dy2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        fix_diam, fix_t,
        small_fix_diam, small_fix_t,
        small_bar_diam, small_bar_t,
        c2);

    translate([-length/4-dx, width/2+dy2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        fix_diam, fix_t,
        small_fix_diam, small_fix_t,
        small_bar_diam, small_bar_t,
        c2);
        
    translate([length/4+dx, width/4+dy/2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        small_fix_diam, small_fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c2);

    translate([-length/4-dx, width/4+dy/2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        small_fix_diam, small_fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c2);

    translate([length/4+dx, -width/4-dy2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        small_fix_diam, small_fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c2);
        
    translate([-length/4-dx, -width/4-dy2,0])
    rotate([0,0,90])
    translate([-width/4, 0,0])
    ceiling_t_bar(width/4, 
        small_fix_diam, small_fix_t,
        fix_diam, fix_t,
        small_bar_diam, small_bar_t,
        c2);
}

module bedroom_ceiling(
    length = bedroom_l, 
    width = bedroom_w, 
    bar_diam = big_bar_diam, 
    bar_t = big_bar_t, 
    explode = false, 
    explode_d = 20) 
{
    c1 = "DarkSlateBlue"; 
    c2 = "MediumSlateBlue";
    c3 = "Grey";
    c4 = "DarkGrey";
    
    bedroom_ceiling_corners(length, width, 
        bar_diam, bar_t, 
        explode, explode_d, 
        c1, c2);
    
    ceiling_grid(length, width,
        bar_diam, bar_t,
        bar_diam, bar_t,
        explode, explode_d, 
        c1, c2, c3, c4); 
    
    text_sz = 8;

    color("Blue") {
    translate([-200,-180,0])
    text("16 pieces of ~60.8 cm long small angle bar (1\" x 1\").", text_sz);
    translate([-200,-190,0])
    text("Other end for small angle bar and the other for big one (1.5\" x 1.5\").", text_sz);
    translate([-200,-200,0])
    text("8 identical and 8 mirror images.", text_sz);
    }

    color("Green") {
    translate([-200,-220,0])
    text("8 identical pieces of ~147.6 cm long small angle bar (1\" x 1\").", text_sz);
    translate([-200,-230,0])
    text("Both ends connect to big angle bar (1.5\" x 1.5\").", text_sz);
    }

    color("Blue") {
    translate([-200,-250,0])
    text("4 identical pieces of ~122.2 cm long big angle bar (1.5\" x 1.5\").", text_sz);
    translate([-200,-260,0])
    text("Both ends connect to big angle bar.", text_sz);
    }

    color("Green") {
    translate([-200,-280,0])
    text("2 identical pieces of ~295.9 cm long big angle bar (1.5\" x 1.5\").", text_sz);
    translate([-200,-290,0])
    text("Both ends connect to big angle bar.", text_sz);
    }

    color("Blue") {
    translate([-200,-310,0])
    text("2 identical pieces of ~276.5 cm long big angle bar.", text_sz);
    translate([-200,-320,0])
    text("Both ends are cut at 45 degrees.", text_sz);
    }

    color("Green") {
    translate([-200,-340,0])
    text("2 identical pieces of ~225.5 cm long big angle bar.", text_sz);
    translate([-200,-350,0])
    text("Both ends are cut at 45 degrees.", text_sz);
    }

    color("Blue") {
    translate([-200,-370,0])
    text("4 identical pieces of ~14.1 cm long big angle bar.", text_sz);
    translate([-200,-380,0])
    text("Both ends are cut at 45 degrees.", text_sz);
    }

    color("Red") {
    translate([-200,-400,0])
    text("MATERIALS: 21.6m of small 1\" x 1\" angle bar, plus extra for cutting.", text_sz);
    translate([-200,-410,0])
    text("21.4m of big 1.5\" x 1.5\" angle bar, plus extra for cutting.", text_sz);
    }
}


module magnified_end_circles()
{
    translate([250,85,0])
    ceiling_t_bar_end_circle(
        bar_diam = 1.5 * 2.54, 
        bar_t = 0.3,
        to_big = true);

    translate([250,-20,0])
    ceiling_t_bar_end_circle(
        bar_diam = 1.0 * 2.54, 
        bar_t = 0.3,
        to_big = true); 

    translate([250,-120,0])
    ceiling_t_bar_end_circle(
        bar_diam = 1.0 * 2.54, 
        bar_t = 0.3,
        to_big = false); 
}

bedroom_ceiling(explode=false);
magnified_end_circles();