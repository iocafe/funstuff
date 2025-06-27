use <anglebarframe.scad> 
use <rectangularframe.scad> 
use <hdim.scad> 
use <mytext.scad> 
use <roof/bolt.scad> 

// If high_king_windows is false, the ready Thailand metal frame
// size is used. If windows are made by ourselves, the
// high_king_windows can be set to true to get bigger windows.
high_king_windows = true;
king_use_square_bar_hatch = true;

king_window_w = high_king_windows ? 70 : 70;
king_window_h = high_king_windows ? 130 : 110;
king_window_hatches = 2;
// king_window_pos = high_king_windows ? 78 : 90;
king_window_pos = high_king_windows ? 85 : 90;
king_nro_vertical_squares = 4;

small_king_window_w = high_king_windows ? 60 : 50;
small_king_window_h = small_king_window_w;
small_king_window_hatches = 2;
small_king_window_pos = king_window_pos + king_window_h - small_king_window_h;
king_small_nro_vertical_squares = 2;

king_square_bar_d = 1.0; // 10mm x 10mm square bar

king_rectangular_tube_w = 1 * 2.54; // two 1" x 2" rectangular tubes
king_rectangular_tube_d = 2 * 2.54;

king_flat_bar_w = 2.50;
king_flat_bar_t = 0.4;

king_small_anglebar_d = 2.54;
king_small_anglebar_t = 0.3;

king_big_anglebar_d = 1.5 * 2.54;
king_big_anglebar_t = 0.4;

king_hinge_anglebar_d = king_big_anglebar_d;
king_hinge_anglebar_t = king_big_anglebar_t;

kinglock_pos = -7;
king_washer_thickness = 0.08;

king_allowance_w = 0.5;
king_allowance_w_center = 1.4;
king_allowance_h = 0.5;
king_hatch_open_allowance = 0.07;

king_hinge_dx = 0;
king_hinge_dy = 2.8;
king_hinge_w = 1.8;
king_hinge_bolthole_d = 0.6;
king_hinge_bolt_length = 0.75 * 2.54;

king_frame_color1 = [0.2, 0.5, 0.2, 1.0];
king_frame_color2 = [0.4, 0.7, 0.3, 1.0];
king_frame_color3 = [0.3, 0.9, 0.3, 1.0];
king_outframe_color1 = [110/255, 69/255, 232/255, 1.0];
king_outframe_color2 = [69/255, 109/255, 232/255, 1.0];

king_hatch_color1 = [0.6, 0.5, 0.2, 1.0];
king_hatch_color2 = [0.8, 0.7, 0.3, 1.0];
king_hatch_color3 = [0.9, 0.9, 0.3, 1.0];
king_rectbar_frame_color1 = [232/255, 69/255, 111/255, 1.0];
king_rectbar_frame_color2 = [232/255, 69/255, 193/255, 1.0];

king_handle_color = [0.4, 0.3, 0.8, 1.0];

module std_king_window(
  wall_thickness=15, 
  open_angle=0, 
  window_pos = king_window_pos, 
  explode=false)
{
    translate([0,
      king_big_anglebar_d
      -2*king_big_anglebar_t,
      window_pos
     +king_window_h/2])
    rotate([90,0,0])
    king_window(wall_thickness, 
        open_angle, 
        king_window_w, king_window_h, 
        king_window_hatches, 
        king_nro_vertical_squares, 
        explode);
}

module std_king_window_hole(
  wall_thickness=15, 
  window_pos = king_window_pos)
{
    translate([0,wall_thickness/2,window_pos+king_window_h/2])
    color("white")
    cube([king_window_w
      +2*king_big_anglebar_t, 
      2*wall_thickness+1.0, 
      king_window_h
      +2*king_big_anglebar_t],center=true); 

    translate([0,king_big_anglebar_d/2,window_pos+king_window_h/2])
    cube([king_window_w
      +2*king_big_anglebar_t
      +2*king_big_anglebar_d, 
      king_big_anglebar_d+0.1, 
      king_window_h
      +2*king_big_anglebar_t
      +2*king_big_anglebar_d],center=true);
}

module small_king_window(
  wall_thickness=15, 
  open_angle=0, 
  window_pos = small_king_window_pos, 
  explode=false)
{
    translate([0,
      king_big_anglebar_d
      -2*king_big_anglebar_t,
      window_pos
     +small_king_window_h/2])
    rotate([90,0,0])
    king_window(wall_thickness, 
        open_angle, 
        small_king_window_w, small_king_window_h, 
        small_king_window_hatches, 
        king_small_nro_vertical_squares, 
        explode);
}

module small_king_window_hole(wall_thickness=15, window_pos = small_king_window_pos)
{
    translate([0,
      wall_thickness/2,
      window_pos+small_king_window_h/2])
    color("white")
    cube([small_king_window_w
      +2*king_big_anglebar_t, 
      2*wall_thickness+1.0, 
      small_king_window_h
      +2*king_big_anglebar_t],center=true); 

    translate([0,
      king_big_anglebar_d/2,
      window_pos+small_king_window_h/2])
    color("white")
    cube([small_king_window_w
      +2*king_big_anglebar_t
      +2*king_big_anglebar_d, 
      king_big_anglebar_d+0.1, 
      small_king_window_h
      +2*king_big_anglebar_t
      +2*king_big_anglebar_d],center=true);  
}

module king_window(wall_thickness=15, open_angle=0, width=king_window_w, height=king_window_h, nro_openings = king_window_hatches,
    nro_vertical_squares=king_nro_vertical_squares,
    explode=false) 
{
  d = explode ? 30 : 0;
  d_move = explode ? 180 : 0;
  
  translate([0,0,king_big_anglebar_d-king_big_anglebar_t+d])
    anglebarframe(
        width + 4*king_big_anglebar_d, 
        height + 4*king_big_anglebar_d, 
        king_big_anglebar_d, 
        king_big_anglebar_t, 
        explode, 
        70,
        king_outframe_color1, 
        king_outframe_color2,
        true);
  
    anglebarframe(
        width + 2*king_big_anglebar_d, 
        height + 2*king_big_anglebar_d, 
        king_big_anglebar_d, 
        king_big_anglebar_t, 
        explode, 
        40,
        king_frame_color1, 
        king_frame_color2,
        true);
    
    fixedgrid(width, height, nro_vertical_squares, explode); 
   
    hatch_in_w = width/2 
        - king_rectangular_tube_w/2 
        - king_allowance_w
        - king_allowance_w_center;

    hatch_in_h = height
        - 2 * king_allowance_h;
    
    hatch_w = hatch_in_w 
        + 2*(king_flat_bar_w - king_small_anglebar_t);

    hatch_h = hatch_in_h 
        + 2*(king_flat_bar_w - king_small_anglebar_t);

    n_hatches = 2;
    hatch_move = hatch_in_w/2
        + king_rectangular_tube_w/2 
        + king_allowance_w_center
        + 2 * d;
    hatch_moves = [-hatch_move, hatch_move];
    for (i = [0:n_hatches-1])
    {
        translate([hatch_moves[i]-2*d_move, 0, king_hatch_open_allowance - d]) 
        rotate([180,0,90])
        if (king_use_square_bar_hatch) {
          windowhatch_sq(hatch_w, hatch_h, open_angle, i,
            nro_vertical_squares, explode); 
        }
        else {
          windowhatch(hatch_w, hatch_h, open_angle, i,
            nro_vertical_squares, explode);  
        }
    } 
}

module fixedgrid(width=70, height=130, nro_vertical_squares=4, explode = true) 
{
  d = explode ? 20 : 0;
  d1 = 0.5 * d;
  d2 = 0.75 * d;
  nro_openings = 2;
  step_x = king_use_square_bar_hatch 
    ? (width+king_rectangular_tube_w+2*king_square_bar_d) 
    / nro_openings 
    : (width+king_rectangular_tube_w+2*king_square_bar_d) 
    / nro_openings;
  color(king_frame_color1) 
  translate([0, 0, 
      -king_rectangular_tube_d/2]) 
  cube([king_rectangular_tube_w, 
      height, king_rectangular_tube_d],
      center=true);

  x1 = king_rectangular_tube_w/2;
  x4 = width/2;
  x2 = step_x/2 - king_square_bar_d/2;
  x3 = x2 + king_square_bar_d;
  translate([0, 0, -king_small_anglebar_d-king_square_bar_d/2])
  {
   for (i = [0:nro_openings-1])
   {
       x = (step_x + 1.5 * d) * (i - nro_openings/2 + 0.5);

       color(king_frame_color2) 
       translate([x, 0, 0]) 
       cube([king_square_bar_d, height, king_square_bar_d],
           center=true);
   }

   step_y = king_use_square_bar_hatch 
     ? (height-king_square_bar_d
     -king_flat_bar_w) 
     / nro_vertical_squares
     : (height-king_square_bar_d
     -king_flat_bar_w) 
     / nro_vertical_squares;
   color(king_frame_color1) 
   for (i = [nro_vertical_squares/-2+1:nro_vertical_squares/2-1])
   {
       y = step_y * i;
       
       translate([0.5 * (x1+x2) + d1, y, 0]) 
       cube([x2-x1, king_square_bar_d, king_square_bar_d],
           center=true);

       translate([0.5 * (x3+x4) + d,
           y, 0])
       cube([x4-x3, king_square_bar_d, king_square_bar_d],
           center=true);

       translate([-0.5 * (x1+x2) - d1,
           y, 0]) 
       cube([x2-x1, king_square_bar_d, king_square_bar_d],
           center=true);

       translate([-0.5 * (x3+x4) - d,
           y, 0]) 
       cube([x4-x3, king_square_bar_d, king_square_bar_d],
           center=true);
   }   
   
   translate([-king_rectangular_tube_w/2
     - king_square_bar_d/2, 
     kinglock_pos, 
     - king_small_anglebar_d+king_square_bar_d])
   kinglock2();
   
   translate([+king_rectangular_tube_w/2
     + king_square_bar_d/2, 
     kinglock_pos, 
     - king_small_anglebar_d+king_square_bar_d])
   kinglock2(explode);
   
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
  
  translate([0,-king_square_bar_d/2,0])
  rotate([0,90,90])
  hdim(king_small_anglebar_d+king_square_bar_d/2,
    king_rectangular_tube_d,0, -d2-12);
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
      king_hinge(step%2==0, false, -height/2, open_angle);
      king_hinge(step%2==0, true, height/2, open_angle);
      
      rotate([step%2 == 0 
        ? -open_angle 
        : open_angle, 0, 0])
      translate([0, dx, dy])
      {
        rectangularframe(length=height, 
            width=width, 
            bar_diam = king_flat_bar_w, 
            bar_t = king_flat_bar_t, 
            explode=explode, 
            c1 = king_rectbar_frame_color1, 
            c2 = king_rectbar_frame_color2);
    
        delta_sz = 2*(king_flat_bar_w-king_flat_bar_t);
        translate([0, 0, king_small_anglebar_d])
        anglebarframe(
            length = height - delta_sz, 
            width = width - delta_sz, 
            bar_diam = king_small_anglebar_d, 
            bar_t = king_small_anglebar_t, 
            explode=explode, 
            explode_d = 40,
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
     } 
   }
} 

module windowhatch_sq(width=70, height=110, open_angle=0, step=0, nro_vertical_squares=king_nro_vertical_squares, explode=false) 
{
    d = explode ? 30 : 0;
    d2 = explode ? 10 : 0;
    
    dx = step%2 == 0 
        ? width/2 + king_hinge_dx 
        : -width/2 - king_hinge_dx;
    dy = king_hinge_dy;
    translate([0, -dx, -dy])
    {
      king_hinge(step%2==0, false, -height/2, open_angle, explode);
      king_hinge(step%2==0, true, height/2, open_angle, explode);
        
      rotate([step%2 == 0 
        ? -open_angle 
        : open_angle, 0, 0])
      translate([0, dx, dy])
      {
        center_pos = king_small_anglebar_d
                  -king_small_anglebar_t
                  -king_square_bar_d/2;
        
        lock_side_pos = -(width/2
          -king_small_anglebar_d
          -king_square_bar_d/2);
        lsp = step%2 == 0 ? -lock_side_pos : lock_side_pos;
        
        translate([kinglock_pos, 
          lsp, 
          center_pos
          +king_square_bar_d])
        kinglock(step%2 == 0, explode);
        
        translate([0, 0, -king_small_anglebar_t])
        rotate([180,0,0])
        anglebarframe(
            length = height, 
            width = width, 
            bar_diam = king_small_anglebar_d, 
            bar_t = king_small_anglebar_t, 
            explode=explode, 
            explode_d = 40,
            c1 = king_hatch_color3, 
            c2 = king_hatch_color2,
            flap_outwards = true);

        delta_sz = 2*king_small_anglebar_d;
        delta_sz2 = delta_sz + 2*king_square_bar_d;
        translate([0, 0, king_small_anglebar_d-king_small_anglebar_t])
        rectangularframe(length=height-delta_sz, 
            width=width-delta_sz, 
            bar_diam = king_square_bar_d, 
            bar_t = king_square_bar_d, 
            explode=explode, 
            c1 = king_rectbar_frame_color1, 
            c2 = king_rectbar_frame_color2);

        color(king_hatch_color1) 
        translate([0, 0, center_pos])
        cube([height-delta_sz2, king_square_bar_d, 
            king_square_bar_d], center=true);
        
        step_y = (height-delta_sz2) 
            / nro_vertical_squares;
        piece_w = (width-delta_sz2-king_square_bar_d)/2;
        for (i = [nro_vertical_squares/-2 + 1
            : nro_vertical_squares/2 - 1])
        {
           y = step_y * i;

           color(king_hatch_color1) 
           translate([y, 
                (piece_w+king_square_bar_d)/2+d2, center_pos]) 
           cube([king_square_bar_d, 
                piece_w, king_square_bar_d],
               center=true);

           color(king_hatch_color1) 
           translate([y, 
                -(piece_w+king_square_bar_d)/2-d2,
                center_pos]) 
           cube([king_square_bar_d, 
                piece_w, king_square_bar_d],
               center=true);
       }   
       
       if (explode) {
           yy = (nro_vertical_squares/2-1) * step_y;
           translate([yy, 
                (piece_w+king_square_bar_d)/2+d2, 
                king_small_anglebar_d 
                - king_small_anglebar_t/2])
           rotate([0,0,90])
           hdim(-piece_w/2, piece_w/2, 0, 12);

           translate([yy, 
                (-piece_w-king_square_bar_d)/2-d2, 
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
     } 
   }
} 


module king_hinge(hinge_at_left, 
  top_hinge, dz, 
  open_angle, 
  explode, 
  scaled=false)
{
  mirror_prm = top_hinge ? 1 : 0;
  king_hinge_frame_fix_h = 1.5;
  hinge_separate 
    = king_hinge_anglebar_t/2;
  coeff= hinge_at_left ? -1 : 1;
  opt_scaling = 0.2;
    
  fix_move_one = -king_hinge_frame_fix_h/2
    + king_hinge_anglebar_t/2+
    - hinge_separate;
  fix_move = -fix_move_one;

  cut_dz2 = 
    2*(king_hinge_anglebar_t 
    +  king_hinge_frame_fix_h)
    + king_washer_thickness+0.2;  

  cube_d = 2*king_small_anglebar_d;
  d = explode ? 4 : 0;

    
  if (!explode) {
    translate([dz-0.5-2*king_washer_thickness,0, 0])
      boltM6(king_hinge_bolt_length);
  }
    
  else {
    translate([-dz,0, 0])
    {
      color("Blue")
      difference() {
        cylinder(r = 11.1, h=0.15, center=true, $fn=30);
        cylinder(r = 11, h=0.28, center=true, $fn=30);
      }

      text_size = 1;

      if (!scaled) {    
        translate([top_hinge ? -15 : 15,
          -2+(hinge_at_left?-15:15), 0])
        mytext([str(
            top_hinge ? "U" : "L",
            hinge_at_left ? "L" : "R")], 1, 15, 10);
      }
      
      if (scaled) {
        translate([top_hinge ?-12:12,-2, 0])
        rotate([0,0, 90])
        mytext([str(top_hinge ? "Upper" : "Lower",
          hinge_at_left ? " left" : " right",
          " corner hinge is made of"),
        str(king_hinge_anglebar_d,
          "cm x ",
          king_hinge_anglebar_d,
          "cm angle bar,"),
        str("metal thickness ", 
          10*king_hinge_anglebar_t, 
          " mm.")],
        3, 25, 5, 1, 1.0);
      } 
    }
  }

  translate([dz-d,0, king_hinge_dy])
  mirror([mirror_prm,0,0])
  {
    difference() 
    {
      union() 
      {
        hinge_top_dx = king_hinge_w/2;
        hinge_bottom_dx = king_hinge_w;
        hinge_top_y = king_hinge_anglebar_d 
          - king_hinge_anglebar_t/2 
          +king_hatch_open_allowance;
        hinge_bottom_y = king_hinge_anglebar_t/2;
                
        p = [ 
          [-hinge_top_dx, hinge_top_y],
          [hinge_top_dx, hinge_top_y],
          [hinge_bottom_dx, hinge_bottom_y],
          [-hinge_bottom_dx, hinge_bottom_y],
          [-hinge_top_dx, hinge_top_y]];
      
        translate([-hinge_separate
          -2*king_washer_thickness 
          +king_hinge_anglebar_t/2,0,
          0]) 
        rotate([-90,0, 90])
        color("DarkGreen")
        linear_extrude(king_hinge_anglebar_t)
        polygon(p);

        translate([fix_move_one-2*king_washer_thickness, 
          0, 
          -king_small_anglebar_t/2
          +king_hatch_open_allowance])
        {
          color("DarkGreen")
          cube([king_hinge_frame_fix_h, 
            2*king_hinge_w, 
            king_hinge_anglebar_t], 
            center=true);
            
            if (scaled) {
                translate([king_hinge_frame_fix_h/2-king_hinge_anglebar_t/2,0,0])
                rotate([-90,0,90])
                mirror([0,mirror_prm,0])
                hdim(-king_hinge_w, king_hinge_w, 0, -4, opt_scaling);
        
                translate([king_hinge_frame_fix_h/2-king_hinge_anglebar_t/2,0,-king_hinge_anglebar_d+king_hinge_anglebar_t/2])
                rotate([90, 0,90])
                mirror([0,mirror_prm,0])
                hdim(-king_hinge_w/2, king_hinge_w/2, 0, -4, opt_scaling);

                translate([-king_hinge_frame_fix_h/2,0,0])
                rotate([0, 0,0])
                mirror([0,mirror_prm,0])
                hdim(0, king_hinge_frame_fix_h, king_hinge_w, -4, opt_scaling);

                translate([king_hinge_anglebar_t,0,-king_hinge_anglebar_d+king_hinge_anglebar_t/2])
                rotate([90,90,90])
                mirror([0,mirror_prm,0])
                hdim(-king_hinge_anglebar_d, 0, 0, -20, opt_scaling);

                translate([2*king_hinge_anglebar_t,0,0])
                rotate([-90,90,90])
                mirror([0,mirror_prm,0])
                hdim(-king_hinge_anglebar_t/2,
                  king_hinge_dy
                  -king_small_anglebar_t/2
                  +king_hatch_open_allowance, 
                  0, -12, opt_scaling);
                  
                translate([king_hinge_frame_fix_h/2+0.05,0,/* -king_hinge_anglebar_d+*/-king_hinge_dy+king_hinge_anglebar_t/2])
                rotate([90, 0, 90])
                mirror([0,mirror_prm,0])
                hdim(-king_hinge_bolthole_d/2, king_hinge_bolthole_d/2, 0, 4, opt_scaling);
            }
         }
      }
        
      translate([0, 0,
        -king_hinge_dy])
        rotate([0,90,0])
      color("DarkGreen") 
      cylinder(
        d = king_hinge_bolthole_d,
        h = 4*king_hinge_anglebar_t,
        center=true, $fn=20);
    }
  }

  rotate([open_angle*coeff, 0, 0])
  translate([dz+d,0, king_hinge_dy])
  mirror([mirror_prm,0,0])
  {
    difference() 
    {
      union() {
        l = king_hinge_w + king_flat_bar_w;
          
        color("Yellow")
        difference()
        {
          translate([hinge_separate, 
            coeff 
            * (-l/2+king_hinge_w/2), 
            - king_hinge_anglebar_d/2 
            - king_small_anglebar_t/2
            + king_hatch_open_allowance/2])
          cube([king_hinge_anglebar_t, 
            l, 
            king_hinge_anglebar_d
            -king_hatch_open_allowance
            -king_small_anglebar_t], 
            center=true);
            
          translate([hinge_separate, 
            +coeff * (king_hinge_w/2 -1),
            -king_hinge_dy 
            -king_hinge_w/2])
          cube([king_small_anglebar_t
            +0.2,
            king_hinge_w+0.2, 
            king_hinge_w+0.2], 
            center=true);

          translate([0,-coeff*(king_hinge_w/2+cube_d/2), 
              -cube_d/2-1.2])
          cube([cut_dz2, cube_d, cube_d], 
            center=true);             
        }
        
        translate([hinge_separate,
            0, 
            -king_hinge_dy])
        rotate([0, 90, 0])
        color("Yellow")
        cylinder(d=king_hinge_w, 
            h=king_hinge_anglebar_t,
            center=true, $fn=25);
      
        translate([fix_move,
          coeff 
          * (-l/2 + king_hinge_w/2),
          -3*king_small_anglebar_t/2])
        color("Yellow")
        cube([king_hinge_frame_fix_h,
          l, 
          king_hinge_anglebar_t],
          center=true);
      }
      
      color("Yellow")
      {
        translate([0, 0, 
          -king_hinge_dy])
        rotate([0,90,0]) 
        cylinder(
          d = king_hinge_bolthole_d, 
          h = cut_dz2, 
          center=true, $fn=20);

        translate([0,
          coeff*7*king_hinge_w/8, 
          -king_hinge_w])
        rotate([-135, 0, 0]) 
        translate([0,-cube_d/2, -cube_d/2])
        cube([cut_dz2, 
          cube_d, cube_d], 
          center=true); 
      }
    }
    
    translate([king_hinge_anglebar_t/2,0,
      -king_hinge_dy])
    rotate([90, 0,90])
    mirror([0, mirror_prm,0])
    hdim(-king_hinge_w/2, king_hinge_w/2, 0, -8, opt_scaling);

    translate([0,0,0])
    rotate([90, 90,90])
    mirror([0,mirror_prm,0])
    hdim(king_hinge_anglebar_d
        -king_hinge_anglebar_t/2+king_hatch_open_allowance,
        king_hinge_anglebar_t/2+king_hatch_open_allowance, 
        0, 12, opt_scaling);

    translate([king_hinge_anglebar_t/2,0, 0])
    rotate([90, 0,90])
    mirror([0, mirror_prm,0])
    hdim(-3.45, king_hinge_w/2, 1,  8, opt_scaling);
    
    translate([0,-3.3,0])
    rotate([90, 90,90])
    mirror([0,mirror_prm,0])
    hdim(king_hinge_anglebar_d
        -2.65,
        king_hinge_anglebar_t/2+king_hatch_open_allowance, 
        0, -12, opt_scaling);
        
    translate([king_hinge_frame_fix_h/2-2*king_hinge_anglebar_t-0.05,
      0,
      -king_hinge_dy+king_hinge_anglebar_t/2])
    rotate([90, 0, 90])
    mirror([0,mirror_prm,0])
    hdim(-king_hinge_bolthole_d/2, 
      king_hinge_bolthole_d/2, 0, 4, 
      opt_scaling);
      
    translate([0,
      -1,
      -king_hinge_anglebar_t])
    rotate([0, 0,0])
    mirror([0,mirror_prm,0])
    hdim(0, king_hinge_frame_fix_h, king_hinge_w, -8, opt_scaling);
  }
  
  if (explode && !scaled) {
    scale([1/opt_scaling,1/opt_scaling,1/opt_scaling])
    king_hinge(hinge_at_left, top_hinge, 0.5*dz, open_angle, explode, true);
  }
}

module kinglock(tongue_to_right, explode, scaled=false)
{
  bolt_diam = 0.5;
  support_l = 4;
  l = king_square_bar_d + 3*king_washer_thickness;
  lockbar_l = 2.4;
  tmp = lockbar_l/2-king_square_bar_d/2;
  p = tongue_to_right ? tmp : -tmp; 
  handle_l = 12;
  d = explode ? 8 : 0;
  opt_scaling = 0.20;
  
  if (explode)
  {
      color("Orange")
      translate([-handle_l/2, 0, 0])
      difference() {
        cylinder(r = 11.1, h=0.15, center=true, $fn=30);
        cylinder(r = 11, h=0.28, center=true, $fn=30);
      }
  }

  difference()
  {
    color(king_hatch_color2)
    translate([-support_l/2
      +king_square_bar_d/2, 
      0, -2*d])
    cube ([support_l, 
      king_square_bar_d, 
      king_square_bar_d], 
      center=true);

    translate([0, 0, -2*d])
    cylinder(d = bolt_diam, h = king_square_bar_d+0.4, center=true, $fn=12);
  }
  
    if (scaled) {
      translate([-support_l/2
        +king_square_bar_d/2, 
        0, -2*d])
      hdim(-support_l/2,support_l/2, 0, 5, opt_scaling);
      
    translate([0, 0, -2*d])
      rotate([0,0,90])
      hdim(-bolt_diam/2,bolt_diam/2, 0, 14, opt_scaling);
      
    }
  
  
  translate([-support_l/2+king_square_bar_d/2, 0, -d])
  {
    difference() {
      color(king_hatch_color1)
      translate([0,p, l])
      cube ([king_square_bar_d, lockbar_l, king_square_bar_d], center=true);

      color(king_hatch_color3)
      translate([0,p+0.5, l+0.60])
      cube ([king_square_bar_d+0.2, lockbar_l, king_square_bar_d], center=true);
      
      translate([0,p+lockbar_l/2 - king_square_bar_d/2, l])
      cylinder(d = bolt_diam, h = king_square_bar_d+0.4, center=true, $fn=12);
    }
  
    if (scaled) {
      translate([0,p, l])
      rotate([0,0,90])
      hdim(-lockbar_l/2,lockbar_l/2, 0, -5, opt_scaling);

      translate([0,p, l])
      rotate([0,0,90])
      hdim(lockbar_l/2-king_square_bar_d/2,lockbar_l/2, 0, 14, opt_scaling);
    }
  }
  
  difference()
  {
    color(king_handle_color)
    translate([-handle_l/2
      +king_square_bar_d/2, 
      0, l+king_square_bar_d])
    cube ([handle_l, 
      king_square_bar_d, 
      king_square_bar_d], 
      center=true);

    translate([0, 
      0, l+king_square_bar_d])
    cylinder(d = bolt_diam, 
      h = king_square_bar_d+0.4, 
      center=true, $fn=12);
  }
  
  if (scaled) {
    translate([-handle_l/2
      +king_square_bar_d/2, 
      0, l+king_square_bar_d])
    hdim(-handle_l/2,handle_l/2, 0, 5, opt_scaling);
  }
  
  translate([0, 0, l+1.5*king_square_bar_d + d])
  rotate([0,90,0])
  bolt(5.0*king_square_bar_d, -1, 
    diameter = bolt_diam, 
    hex_diameter = 0.8,
    hex_length = 0.48,
    washer_thickness = 0.10);
  
  if (explode && !scaled && tongue_to_right) {
    translate([-120,290,0])
    scale([1/opt_scaling,1/opt_scaling,1/opt_scaling])
    kinglock(tongue_to_right, explode, scaled=true);
  }
}

module kinglock2(explode) 
{
  lockpiece_l = 4;
  color(king_hatch_color1)
  translate([0, -lockpiece_l/2+king_square_bar_d/2, 0])
  cube ([king_square_bar_d, lockpiece_l, king_square_bar_d], center=true);
}


// For testing
 std_king_window(open_angle=90 /* $t*179,  */, explode=false);
// king_window(open_angle= 0, explode=false);
// small_king_window(open_angle= 90, explode=false);
// windowhatch(width=70, height=130, explode=false);
// windowhatch_sq(width=70, height=130, explode=false);
//fixedgrid(explode=true);