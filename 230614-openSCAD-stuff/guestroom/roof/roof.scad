use <../metals.scad> 
use <bolt.scad> 

roof_overlap = 70;
roof_center_overlap = 80;
roof_center_vent = 40;
roof_left_longitunal_overlap = 40;
roof_right_longitunal_overlap = 70;
roof_metal_extra_overlap = 10;
roof_cut_overlap = 30;
roof_cut_longitunal_overlap = 20;
roof_angle = 20;
sink_roof = 21;

c_bar_width = 2.0 * 2.54;
c_bar_height = 3 * 2.54;
c_bar_thickn = 0.5;
c_bar_color = "DarkGray";
c_bar_extra_length_for_p6_weld = c_bar_width-2*c_bar_thickn;
c_bar_merge_weld_len = 30;

c_purlin_w = 2*2.54;
c_purlin_h = 3*2.54;
c_purlin_color = "DarkRed";
c_purlin_end_d = 3;

c_purlin6_w = 2 * 2.54;
c_purlin6_h = 6 * 2.54;

bolt_material_and_washer_thickn = 1.2;
part3_move = -20;

// Show roof: 0 = no, 1 = truss supports, 2=+furlings, 3=+transparent roof metal, 4 = +opaque roof metal.
module roof(house_length, house_width, toilet_cut_d, truss_pos, n_truss, show_roof)
{
    if (show_roof > 0.5) {
        translate([0,0,-sink_roof])
        roof2(house_length, house_width, toilet_cut_d,
            truss_pos, n_truss, show_roof);
    }
}

module roof2(house_length, house_width, toilet_cut_d, truss_pos, n_truss, show_roof)
{
    width = house_width + 2 * roof_overlap;
    
    purlins_length = house_length
        + roof_left_longitunal_overlap
        + roof_right_longitunal_overlap;

    short_purlins_length = house_length 
        - toilet_cut_d[0] 
        + roof_left_longitunal_overlap
        + roof_cut_longitunal_overlap;
    
    short_purling_center = -((house_length
        - toilet_cut_d[0])/2
        + (roof_cut_longitunal_overlap 
        - roof_left_longitunal_overlap)/2);
            
    purlins_w1 = (width/2 + roof_center_overlap 
        - c_purlin_end_d) / cos(roof_angle);
    dxx1 = width/4 - roof_center_overlap/2 - c_purlin_end_d/2;
    dyy1 = (dxx1+roof_center_overlap
        + c_purlin_end_d) * tan(roof_angle)
        + c_bar_height / cos(roof_angle);
    
    cut_w = toilet_cut_d[1] 
        + roof_overlap
        + roof_metal_extra_overlap
        - roof_cut_overlap;
    cut_l = purlins_length
        - short_purlins_length; 
    
    for (i=[0:n_truss-1])
    {
        translate([0,-truss_pos[i], c_bar_height/2])
        roof_truss(width, 
            i<0.5, i>n_truss-1.5, 
            cut_w/cos(roof_angle));
    }

    part3_up = (width/2-part3_move) * tan(roof_angle) 
        - 2.3/cos(roof_angle)*c_bar_height;
    long_bar = truss_pos[n_truss-1] - truss_pos[0] + 2*c_bar_width;

    // Longitunal C bar at top center + bolts
    topbar_x = part3_move+c_bar_height/2;
    translate([topbar_x, 
        -truss_pos[0]-long_bar/2+c_bar_width, part3_up])
    rotate([0,0,-90]) 
    c_bar(long_bar, "SlateGray", c_bar_width, 
        c_bar_height, c_bar_thickn);
    for (i=[0:n_truss-1])
    {
        translate([topbar_x + bolt_material_and_washer_thickn/2,
            -truss_pos[i]+c_bar_width/2,
            part3_up])
        rotate([0,0,180]) bolt();
    }
    
    // Longitunal C bar at bottom center + bolts
    translate([part3_move+c_bar_height/2,
        -truss_pos[0]-long_bar/2 + c_bar_width,
        1.5 * c_bar_height+sink_roof])
    rotate([0,0,-90]) 
    c_bar(long_bar, "SlateGray", c_bar_width,
        c_bar_height, c_bar_thickn); 
    for (i=[0:n_truss-1])
    {
        translate([topbar_x + bolt_material_and_washer_thickn/2,
            -truss_pos[i]+c_bar_width/2,
            1.5 * c_bar_height + sink_roof])
        rotate([0,0,180]) bolt();
    }

    ll = part3_up - 1.5 * c_bar_height - sink_roof;
    diag_l = ll * sqrt(2);
    dy = -truss_pos[0] - 8;
    dd = ll/2 - c_bar_height/6;
        
    translate([part3_move+c_bar_height/2, -ll/2 + dy, part3_up-ll/2])
    {
        rotate([0,-45,90]) 
        c_bar(diag_l, "Gray", c_bar_width, 
            c_bar_height, c_bar_thickn); 
    
        translate([0, dd, dd])
        rotate([0,0,180]) bolt();

        translate([0, -dd, -dd])
        rotate([0,0,180]) bolt();
    }
    
    if (show_roof > 1.5) 
    {
        translate([-dxx1, -house_length/2 
            + (roof_left_longitunal_overlap 
            - roof_right_longitunal_overlap)/2, dyy1])
        rotate([0,-roof_angle,0])
        c_purlins_and_roof_metal(purlins_length, 
            purlins_w1, 7, show_roof, cut_l, cut_w/cos(roof_angle));
        
        purlins_w2 = (width/2 - roof_center_vent
            - c_purlin_end_d) / cos(roof_angle);
        dxx2 = width/4 + roof_center_vent/2 - c_purlin_end_d/2;
        dyy2 = (dxx2-roof_center_vent+c_purlin_end_d)
            * tan(roof_angle)
             + c_bar_height / cos(roof_angle);
        translate([dxx2, -house_length/2 
             + (roof_left_longitunal_overlap 
             - roof_right_longitunal_overlap)/2, dyy2])
        rotate([0,-roof_angle,180])
        c_purlins_and_roof_metal(purlins_length, 
            purlins_w2, 5, show_roof); 
    }
}

module roof_truss(width = 400, 
    is_first_truss=false, is_last_truss=false,
    cut_w = 0)
{
    split_bottom_bar_at = is_last_truss ? 0.47 : 0.31; /* 0 - 1.0 */
    narrower = sink_roof / tan(roof_angle);
    narrower_width = width - 2 * narrower;
    if (is_first_truss) {
        pos1 = -narrower_width/2 
            + split_bottom_bar_at 
            * narrower_width
            - c_bar_merge_weld_len/2
            + c_bar_height/2;
        h1 = (width/2 + pos1) * tan(roof_angle) 
            - sink_roof + c_bar_height;
        pos_z = sink_roof+h1/2-c_bar_height/2;
        pos_z_bolt = sink_roof+h1-c_bar_height;
        translate([pos1,0,pos_z])
        rotate([0,90,0])
        c_bar(h1, "DarkSlateGray", c_bar_width, c_bar_height); 
        
        translate([pos1,
            -bolt_material_and_washer_thickn/2, pos_z_bolt])
        rotate([0,0,90]) bolt();
    }
    else if (!is_last_truss) {
        part1 = split_bottom_bar_at
            * narrower_width  
            + c_bar_merge_weld_len/2;
        translate([(-narrower_width+part1)/2,0,sink_roof])
        c_bar(part1, "DarkSlateGray", c_bar_width, c_bar_height); 
    }
    
    part2 = (1.0-split_bottom_bar_at)
        * narrower_width 
        + c_bar_merge_weld_len/2;
    translate([(narrower_width-part2)/2,0,sink_roof])
    rotate([180,0,0]) 
    c_bar(part2, "SlateGray", c_bar_width, c_bar_height); 
  
    part3 = (width/2+part3_move) * tan(roof_angle)
        + 0.8 * c_bar_height - sink_roof;
    translate([part3_move,0,part3/2 - 0.52*c_bar_height+sink_roof])
    rotate([0,90,0]) c_bar(part3, "Gray", c_bar_width, c_bar_height); 

    l1 = (width/2) / cos(roof_angle);
    translate([width/2, 0, width/2*tan(roof_angle)])
    rotated_c_bar(l1+c_bar_extra_length_for_p6_weld, 
        -roof_angle, false, width/2);

    l2 = l1 + roof_center_overlap/cos(roof_angle);
    if (is_last_truss) {
        translate([-c_bar_extra_length_for_p6_weld-1.5,
            0, cut_w * sin(roof_angle)
            -sin(roof_angle) * c_bar_extra_length_for_p6_weld])
        rotated_c_bar(l2 - cut_w
            + 2 * c_bar_extra_length_for_p6_weld, 
            roof_angle, true, 
            width/2-cut_w * cos(roof_angle), "SlateGrey");
    }
    else {
         translate([-c_bar_extra_length_for_p6_weld-1.5,
                0, 
                -sin(roof_angle) * c_bar_extra_length_for_p6_weld])
         rotated_c_bar(l2
            + 2*c_bar_extra_length_for_p6_weld, 
            roof_angle, true, width/2, "SlateGrey");
    }
    
    translate([-narrower_width/2 + 0.6*c_bar_height,
        -bolt_material_and_washer_thickn/2,
        sink_roof + 0.2*c_bar_height])
    rotate([0,0,90]) bolt();

    translate([narrower_width/2 - 0.6*c_bar_height,
        -bolt_material_and_washer_thickn/2,
        sink_roof + 0.2*c_bar_height])
    rotate([0,0,90]) bolt();

    if (!is_last_truss) {
        translate([-narrower_width/2 
            + split_bottom_bar_at
            * narrower_width 
            - (c_bar_merge_weld_len/2-5),
            -bolt_material_and_washer_thickn/2, sink_roof])
        rotate([0,0,90]) bolt();
    }
    
    if (!is_first_truss && !is_last_truss) {
        translate([-narrower_width/2 
            + split_bottom_bar_at
            * narrower_width
            + (c_bar_merge_weld_len/2-5),
            -bolt_material_and_washer_thickn/2, sink_roof])
        rotate([0,0,90]) bolt();
    }

    translate([part3_move,
        -bolt_material_and_washer_thickn/2, sink_roof])
    rotate([0,0,90]) bolt();
    
    translate([part3_move,
        -bolt_material_and_washer_thickn/2, 
        part3-c_bar_height+sink_roof])
    rotate([0,0,90]) bolt();

    top_bolt_y = width/2 * tan(roof_angle)-1;
    translate([2,
        -bolt_material_and_washer_thickn/2, top_bolt_y])
    rotate([0,0,90]) bolt();
}

module rotated_c_bar(length, angle, flip, move_x, c = "DarkGrey")
{
    dx = length/2;
    dz = c_bar_height/2;
    
    cube_sz = 3*c_bar_height+0.1;
    cube_w = c_bar_width+0.1;
    extra_for_cuts = c_bar_height;

    /* if (flip) { */
    translate([-move_x, 0, dz])
    rotate([0,-angle,0])
    {
        difference()
        {
            translate([dx, 0, -dz])
            rotate([flip?180:0,0,0])
            
            c_bar(length+2*extra_for_cuts, 
                c, c_bar_width, c_bar_height); 
     
            translate([0, flip?0:c_bar_width, -c_bar_height/2]) 
            rotate([0,angle,0])
            translate([-cube_sz/2, -cube_w/2, 0]) 
            color("Black") 
            cube([cube_sz, cube_w+0.2, cube_sz], center=true);

            translate([length, 
                flip?0:c_bar_width, -c_bar_height/2]) 
            rotate([0,angle,0])
            translate([cube_sz/2, 
                -c_bar_width/2, 0]) 
            color("Black") 
            cube([cube_sz, cube_w+0.2, cube_sz], center=true);
        }
    }
}

module c_purlins_and_roof_metal(length, width, n, show_roof,
    cut_l=0, cut_w=0)
{
    step = (width - 2*c_purlin_h) / (n - 1);
    for (i = [0:n-1]) {
        pos = i * step - width/2 + c_purlin_w/2+c_purlin_h/2;
        use_small = pos < -(width/2+roof_metal_extra_overlap-cut_w) && cut_w > 0;
        le = use_small ? length - cut_l : length;
        translate([pos, use_small?cut_l/2:0, c_purlin_w])
        rotate([-90,0,90])
        c_purlin(le, c_purlin_color, 
            c_purlin_w, c_purlin_h);
    }
    
    l1 = width+2*c_purlin6_w;
    p1 = length/2+c_purlin6_w;
    p6_c = show_roof > 3.5 
        ? [19/255, 52/255, 27/255,1] 
        : [19/255, 52/255, 27/255,0.6];
    
    translate([0, p1, c_purlin_w])
    mirror([0,1,0])
    c_purlin6_angled(l1, 
        left_45 = 45, left_roof_angle = roof_angle, 
        right_45 = 45, right_roof_angle = -roof_angle,
        c=p6_c);

    translate([cut_w > 0 ? cut_w/2:0, -p1, c_purlin_w])
    c_purlin6_angled(cut_w > 0 ? l1-cut_w: l1, 
        left_45 = 45, left_roof_angle = roof_angle, 
        right_45 = 45, right_roof_angle = -roof_angle,
        c=p6_c);

    l2 = length+2*c_purlin6_w;
    p2 = width/2+c_purlin_w;
    
    translate([p2, 0, c_purlin_w-1.4])
    rotate([0,roof_angle, 0])
    rotate([0,0,90])
    c_purlin6_angled(l2, 
        left_45 = 45, right_45 = 45,
        c=p6_c);

    translate([-p2, cut_l > 0 ? cut_l/2 : 0, c_purlin_w-0.4])
    rotate([0,roof_angle, 0])
    rotate([0,0,-90])
    c_purlin6_angled(cut_l > 0 ? l2-cut_l : l2, 
        left_45 = 45, right_45 = 45,
        c=p6_c);

    if (cut_l > 0) {
        translate([-p2+cut_w,
            -l2/2+cut_l/2, 
            c_purlin_w-0.4])
        rotate([0,roof_angle, 0])
        rotate([0,0,-90])
        c_purlin6_angled(cut_l, 
            left_45 = -45, right_45 = 45,
        c=p6_c);
        
        translate([-l1/2 + cut_w/2, -p1+cut_l, c_purlin_w])
        c_purlin6_angled(cut_w, 
            left_45 = 45, left_roof_angle = roof_angle, 
            right_45 = -45, right_roof_angle = -roof_angle,
        c=p6_c);
    }

    metal_color = (show_roof > 3.5) 
        ? [35/255, 114/255, 39/255, 1.0]
        : [35/255, 144/255, 39/255, 0.4];
    
    if (show_roof > 2.5) difference() {
        translate([width/2+roof_metal_extra_overlap, 0, c_purlin_w])
        rotate([0,0,90])
        roof_piece(width+2*roof_metal_extra_overlap, 
            length + 2*roof_metal_extra_overlap, 
            metal_color);
        
        if (cut_l > 0.0) {
            cut_h = c_purlin_h + c_bar_height;
            move_x = -(width/2+roof_metal_extra_overlap-cut_w/2);
            move_y = -(length/2+roof_metal_extra_overlap-cut_l/2);
            translate([move_x,move_y,0])
            cube([cut_w, cut_l, cut_h], center=true);
        }
    }
}

toilet_cut_d = [85, 105];
truss_pos = [10, 100, 200];
n_truss = 3;
roof(215, 410, toilet_cut_d, truss_pos, n_truss, 2);

// rotated_c_bar(100, 30, true, 0, c = "DarkGrey");
