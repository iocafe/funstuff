use <anglebarframe.scad> 
use <rectangularframe.scad> 
use <hdim.scad> 

// If high_king_windows is false, the ready Thailand metal frame
// size is used. If windows are made by ourselves, the
// high_king_windows can be set to true to get bigger windows.
high_king_windows = true;

king_window_w = high_king_windows ? 75 : 70;
king_window_h = high_king_windows ? 135 : 110;
king_window_hatches = 2;
king_window_pos = high_king_windows ? 80 : 90;
king_nro_vertical_squares = 4;

wide_king_window_w = 2 * king_window_w;
wide_king_window_h = king_window_h;
wide_king_window_hatches = 4;

small_king_window_w = high_king_windows ? 60 : 50;
small_king_window_h = small_king_window_w;
small_king_window_hatches = 2;
small_king_window_pos = king_window_pos + king_window_h - small_king_window_h;
king_small_nro_vertical_squares = 2;

king_square_bar_d = 1.0; // 10mm x 10mm square bar

king_rectangular_tube_w = 2 * 2.54; // two 1" x 2" rectangular tubes
king_rectangular_tube_d = 2 * 2.54;

king_flat_bar_w = 2.54;
king_flat_bar_t = 0.3;

king_small_anglebar_d = 2.54;
king_small_anglebar_t = 0.3;

king_big_anglebar_d = 1.5 * 2.54;
king_big_anglebar_t = 0.4;

king_allowance_w = 0.4;
king_allowance_h = 0.4;
king_hinge_dx = 1;
king_hinge_dy = 3;
king_frame_color1 = [0.2, 0.5, 0.2, 1.0];
king_frame_color2 = [0.4, 0.7, 0.3, 1.0];
king_frame_color3 = [0.3, 0.9, 0.3, 1.0];

king_hatch_color1 = [0.6, 0.5, 0.2, 1.0];
king_hatch_color2 = [0.8, 0.7, 0.3, 1.0];
king_hatch_color3 = [0.9, 0.9, 0.3, 1.0];

module std_king_window(wall_thickness=15, open_angle=0, window_pos = king_window_pos, explode=false)
{
    translate([0,0,window_pos])
    king_window(wall_thickness, open_angle, 
        king_window_w, king_window_h, 
        king_window_hatches, 
        king_nro_vertical_squares, explode);
}

module king_window_hole(wall_thickness=15, window_pos = king_window_pos)
{
    translate([0,wall_thickness/2,window_pos+king_window_h/2])
    color("white")
    cube([king_window_w, wall_thickness+1.0, king_window_h],center=true);
}

module wide_king_window(wall_thickness=15, open_angle=0, window_pos = king_window_pos, explode=false)
{
    translate([0,0,window_pos])
    king_window(wall_thickness, open_angle, 
        wide_king_window_w, wide_king_window_h, 
        wide_king_window_hatches, 
        king_nro_vertical_squares,
        explode);
}

module wide_king_window_hole(wall_thickness=15, window_pos = king_window_pos)
{
    translate([0,wall_thickness/2,window_pos+wide_king_window_h/2])
    color("white")
    cube([wide_king_window_w, wall_thickness+1.0, wide_king_window_h],center=true);
}

module small_king_window(wall_thickness=15, open_angle=0, window_pos = small_king_window_pos, explode=false)
{
    translate([0,0,window_pos])
    king_window(wall_thickness, open_angle, 
        small_king_window_w, small_king_window_h, 
        small_king_window_hatches, 
        king_small_nro_vertical_squares, 
        explode);
}

module small_king_window_hole(wall_thickness=15, window_pos = small_king_window_pos)
{
    translate([0,wall_thickness/2,window_pos+small_king_window_h/2])
    color("white")
    cube([small_king_window_w, wall_thickness+1.0, small_king_window_h],center=true);
}

module king_window(wall_thickness=15, open_angle=0, width=king_window_w, height=king_window_h, nro_openings = king_window_hatches,
    nro_vertical_squares=king_nro_vertical_squares,
    explode=false) 
{
    anglebarframe(
        width + 2*king_big_anglebar_d, 
        height + 2*king_big_anglebar_d, 
        king_big_anglebar_d, 
        king_big_anglebar_t, 
        explode, 
        king_frame_color1, 
        king_frame_color2,
        true);
    
    fixedgrid(width, height, nro_vertical_squares, explode); 
   
    hatch_in_w = width/2 
        - king_rectangular_tube_w/2 
        - 3 * king_allowance_w;

    hatch_in_h = height
        - 2 * king_allowance_h;
    
    hatch_w = hatch_in_w 
        + 2*(king_flat_bar_w - king_small_anglebar_t);

    hatch_h = hatch_in_h 
        + 2*(king_flat_bar_w - king_small_anglebar_t);

    n_hatches = 2;
    hatch_move = hatch_in_w/2
        + king_rectangular_tube_w/2 
        + 2*king_allowance_w;
    hatch_moves = [-hatch_move, hatch_move];
    for (i = [0:n_hatches-1])
    {
        translate([hatch_moves[i], 0, 0]) 
        rotate([180,0,90])
        windowhatch(hatch_w, hatch_h, open_angle, i,
            nro_vertical_squares, explode); 
    } 
}

module fixedgrid(width=75, height=130, nro_vertical_squares=4, explode = true) 
{
  d = explode ? 30 : 0;
  d1 = 0.5 * d;
  d2 = 0.75 * d;
  nro_openings = 2;
  step_x = (width+king_rectangular_tube_w) 
        / nro_openings + 1.5 * d;
  color(king_frame_color1) 
  translate([0, 0, 
      -king_rectangular_tube_d/2]) 
  cube([king_rectangular_tube_w, 
      height, king_rectangular_tube_d],
      center=true);

  x1 = king_rectangular_tube_w/2;
  x4 = width/2;
  x2 = 0.5*(x1+x4) - king_square_bar_d/2;
  x3 = x2 + king_square_bar_d;
  w = x2-x1;
    
  translate([0, 0, -king_small_anglebar_d-king_square_bar_d/2])
  {
   for (i = [0:nro_openings-1])
   {
       x = step_x * (i - nro_openings/2 + 0.5);

       color(king_frame_color2) 
       translate([x, 0, 0]) 
       cube([king_square_bar_d, height, king_square_bar_d],
           center=true);
   }

   step_y = (height+king_square_bar_d) / nro_vertical_squares;
   color(king_frame_color1) 
   for (i = [nro_vertical_squares/-2+1:nro_vertical_squares/2-1])
   {
       y = step_y * i;
       
       translate([0.5 * (x1+x2) + d1, y, 0]) 
       cube([w, king_square_bar_d, king_square_bar_d],
           center=true);

       translate([0.5 * (x3+x4) + d,
           y, 0])
       cube([w, king_square_bar_d, king_square_bar_d],
           center=true);

       translate([-0.5 * (x1+x2) - d1,
           y, 0]) 
       cube([w, king_square_bar_d, king_square_bar_d],
           center=true);

       translate([-0.5 * (x3+x4) - d,
           y, 0]) 
       cube([w, king_square_bar_d, king_square_bar_d],
           center=true);
   }   
   
   if (explode) {
       hdim_y = step_y * (nro_vertical_squares/4);
       translate([0, step_y,0])
       {
           hdim(x1+d1, x2+d1, 0);
           hdim(x3+d, x4+d, 0);
       }
   }

   rotate([0,0,90])
   hdim(-height/2, height/2, 0, 5);

   if (explode) {
        translate([-king_rectangular_tube_w/2,0, 0])
       rotate([0, 0,90]) 
       {
            hdim(0, height/2, 0,-(width/2+d+15));
            hdim(-height/2, 0, 0, -(width/2+d+15));
        }

        translate([width/2+d,0, 0])
        rotate([0,0,90]) 
        {
            hdim(-step_y, 0, 0, 5);
            hdim(-height/2, -step_y, 0, 5);
        }
    }
    else {
        hdim(-width/2, width/2, step_y, -step_y-5);
    } 
  }
  
  translate([0,0,0])
  rotate([0,90,90])
  hdim(0, king_small_anglebar_d+king_square_bar_d/2,0, d2+12);
}

module windowhatch(width=70, height=110, open_angle=0, step=0, nro_vertical_squares=king_nro_vertical_squares, explode=false) 
{
    d = explode ? 20 : 0;
    d2 = explode ? 10 : 0;
    
    dx = step%2 == 0 
        ? width/2 + king_hinge_dx 
        : -width/2 - king_hinge_dx;
    dy = king_hinge_dy;
    translate([0, -dx, -dy])
    {
    rotate([0,90,0]) cylinder(r = 0.4, h =height, center=true);
    rotate([step%2 == 0 ? -open_angle : open_angle, 0, 0])
    translate([0, dx, dy])
    {
        translate([0, 0, -d])
        rectangularframe(length=height, 
            width=width, 
            bar_diam = king_flat_bar_w, 
            bar_t = king_flat_bar_t, 
            explode=explode, 
            c1 = king_hatch_color2, 
            c2 = king_hatch_color3);
    
        delta_sz = 2*(king_flat_bar_w-king_flat_bar_t);
        translate([0, 0, king_small_anglebar_d])
        anglebarframe(
            length = height - delta_sz, 
            width = width - delta_sz, 
            bar_diam = king_small_anglebar_d, 
            bar_t = king_small_anglebar_t, 
            explode=explode, 
            c1 = king_hatch_color3, 
            c2 = king_hatch_color2);

        delta_sz2 = delta_sz + 2*king_small_anglebar_d;
        color(king_hatch_color1) 
        translate([0, 0, 
                king_small_anglebar_d 
                - king_small_anglebar_t/2])
        cube([height-delta_sz2, king_flat_bar_w, 
            king_flat_bar_t], center=true);
        
        step_y = (height-delta_sz2+king_flat_bar_w) 
            / nro_vertical_squares;
        piece_w = (width-delta_sz2-king_flat_bar_w)/2;
        for (i = [nro_vertical_squares/-2 + 1
            : nro_vertical_squares/2 - 1])
        {
           y = step_y * i;

           color(king_hatch_color1) 
           translate([y, 
                (piece_w+king_flat_bar_w)/2+d2,
                king_small_anglebar_d 
                - king_small_anglebar_t/2]) 
           cube([king_flat_bar_w, 
                piece_w, king_flat_bar_t],
               center=true);

           color(king_hatch_color1) 
           translate([y, 
                -(piece_w+king_flat_bar_w)/2-d2,
                king_small_anglebar_d 
                - king_small_anglebar_t/2]) 
           cube([king_flat_bar_w, 
                piece_w, king_flat_bar_t],
               center=true);
       }   
       
       if (explode) {
           yy = (nro_vertical_squares/2-1) * step_y;
           translate([yy, 
                (piece_w+king_flat_bar_w)/2+d2, 
                king_small_anglebar_d 
                - king_small_anglebar_t/2])
           rotate([0,0,90])
           hdim(-piece_w/2, piece_w/2, 0, 12);
           
           dd = (height-delta_sz2)/2;
           translate([0,  0, 
                king_small_anglebar_d 
                - king_small_anglebar_t/2])
           hdim(-dd, dd, 0, 3);
       }
   } }
} 


module genericframe(width=70, height=110, profile_width = 5, profile_depth = 8) 
{
    translate([-(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);
    
    translate([(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);

    translate([0, 0, -(height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);

    translate([0, 0, (height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);
}    

// For testing
// std_king_window(open_angle=90 /* $t*179 */, window_pos =0, explode=false);
king_window(open_angle=5 /* $t*179 */, explode=false);
//windowhatch(width=75, height=135, explode=false);
// fixedgrid(explode=false);