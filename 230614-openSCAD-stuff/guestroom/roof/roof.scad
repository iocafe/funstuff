use <../metals.scad> 
use <bolt.scad> 

roof_overlap = 75;
roof_center_overlap = 80;
roof_longitunal_overlap = 60;
roof_angle = 20;
sink_roof = 21;

c_bar_width = 2.0 * 2.54;
c_bar_height = 3 * 2.54;
c_bar_thickn = 0.5;
c_bar_color = "DarkGray";

c_purlin_w = 2*2.54;
c_purlin_h = 3*2.54;
c_purlin_color = "DarkRed";


bolt_material_and_washer_thickn = 1.2;
part3_move = 20;

module roof(house_length, house_width, truss_pos, n_truss)
{
    translate([0,0,-sink_roof])
    roof2(house_length, house_width, truss_pos, n_truss);
}

module roof2(house_length, house_width, truss_pos, n_truss)
{
    width = house_width + 2 * roof_overlap;
    
    for (i=[0:n_truss-2])
    {
        translate([0,-truss_pos[i], c_bar_height/2])
            roof_truss(width);
    }

    translate([0,-truss_pos[n_truss-1], c_bar_height/2])
        roof_truss(width);

    part3_up = (width/2-part3_move) * tan(roof_angle) 
        - c_bar_height;
    long_bar = truss_pos[n_truss-1] - truss_pos[0] + c_bar_width;

    // Longitunal C bar at top center + bolts
    topbar_x = part3_move+c_bar_height/2;
    translate([topbar_x, -long_bar/2, part3_up])
    rotate([0,0,-90]) 
    c_bar(long_bar, "SlateGray", c_bar_width, 
        c_bar_height, c_bar_thickn);
    for (i=[0:n_truss-1])
    {
        translate([topbar_x + bolt_material_and_washer_thickn/2,
            -truss_pos[i]-c_bar_width/2,
            part3_up])
        rotate([0,0,180]) bolt();
    }
    
    // Longitunal C bar at bottom center + bolts
    translate([part3_move+c_bar_height/2,-long_bar/2,
        1.5 * c_bar_height+sink_roof])
    rotate([0,0,-90]) 
    c_bar(long_bar, "SlateGray", c_bar_width,
        c_bar_height, c_bar_thickn); 
    for (i=[0:n_truss-1])
    {
        translate([topbar_x + bolt_material_and_washer_thickn/2,
            -truss_pos[i]-c_bar_width/2,
            1.5 * c_bar_height + sink_roof])
        rotate([0,0,180]) bolt();
    }

    ll = part3_up - 1.5 * c_bar_height - sink_roof;
    diag_l = ll * sqrt(2);
    dy = -7;
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
    
    purlins_length = truss_pos[n_truss-1] - truss_pos[0] 
        + 2*c_bar_width
        + 2*roof_longitunal_overlap;
    
    purlins_w = (width/2 +roof_center_overlap) / cos(roof_angle);
    dxx = width/4 - roof_center_overlap/2;
    dyy = dxx * tan(roof_angle) + sink_roof 
        + (c_bar_height + c_purlin_h) / cos(roof_angle);
    translate([-dxx, -house_length/2, dyy])
    rotate([0,-roof_angle,0])
    roof_c_purlins(purlins_length, purlins_w, 7);
}

module roof_truss(width = 400)
{
    narrower = sink_roof / tan(roof_angle);
    narrower_width = width - 2 * narrower;
    part1 = 3*narrower_width/4  + 40;
    translate([(-narrower_width+part1)/2,0,sink_roof])
    c_bar(part1, "DarkSlateGray", c_bar_width, c_bar_height); 
    
    part2 = narrower_width/4 + 40;
    translate([(narrower_width-part2)/2,0,sink_roof])
    rotate([180,0,0]) c_bar(part2, "SlateGray", c_bar_width, c_bar_height); 
  
    part3 = (width/2-part3_move) * tan(roof_angle)
        + 0.8 * c_bar_height - sink_roof;
    translate([part3_move,0,part3/2 - 0.52*c_bar_height+sink_roof])
    rotate([180,90,0]) c_bar(part3, "Gray", c_bar_width, c_bar_height); 

    l1 = (width/2) / cos(roof_angle);
    rotated_c_bar(l1, roof_angle, false, width/2);

    l2 = l1 + roof_center_overlap/cos(roof_angle);
    rotated_c_bar(l2, roof_angle, true, width/2, "SlateGrey");
    
    translate([-narrower_width/2 + 0.6*c_bar_height,
        -bolt_material_and_washer_thickn/2,
        sink_roof + 0.2*c_bar_height])
    rotate([0,0,90]) bolt();

    translate([narrower_width/2 - 0.6*c_bar_height,
        -bolt_material_and_washer_thickn/2,
        sink_roof + 0.2*c_bar_height])
    rotate([0,0,90]) bolt();

    translate([1*narrower_width/4 + 30,
        -bolt_material_and_washer_thickn/2, sink_roof])
    rotate([0,0,90]) bolt();

    translate([1*narrower_width/4 - 30,
        -bolt_material_and_washer_thickn/2, sink_roof])
    rotate([0,0,90]) bolt();

    translate([part3_move,
        -bolt_material_and_washer_thickn/2, sink_roof])
    rotate([0,0,90]) bolt();
    
    translate([part3_move,
        -bolt_material_and_washer_thickn/2, 
        part3-c_bar_height+sink_roof])
    rotate([0,0,90]) bolt();

    top_bolt_y = width/2 * tan(roof_angle);
    translate([2,
        -bolt_material_and_washer_thickn/2, top_bolt_y])
    rotate([0,0,90]) bolt();
}

module rotated_c_bar(length, angle, flip, move_x, c = "DarkGrey")
{
    dx = length/2;
    dz = c_bar_height/2;

    if (flip) {
        
        translate([-move_x, 0, dz])
        rotate([0,-angle,0])
        translate([dx, 0, -dz])
        rotate([180,0,0])
        c_bar(length, c, c_bar_width, c_bar_height); 
    }
    else {
        translate([move_x, 0, dz])
        rotate([0,angle,0])
        translate([-dx, 0, -dz])
        c_bar(length, c, c_bar_width, c_bar_height); 
    }
}

module roof_c_purlins(length, width, n)
{
    step = (width - c_purlin_w) / (n - 1);
    for (i = [0:n-1]) {
        translate([i * step - width/2+c_purlin_w, 0, c_purlin_h/2])
        rotate([0,0,90])
        c_purlin(length, c_purlin_color, 
            c_purlin_w, c_purlin_h);
    } 
    
    translate([width/2, 0, c_purlin_h])
    rotate([0,0,90])
    roof_piece(width, length);
}


truss_pos = [0, 100, 200];
n_truss = 3;
roof(200, 400, truss_pos, n_truss);