use <../hdim.scad>

pipe_depth_from_floor = 25;
toilet_bowl_d_from_back_wall = 30;
toilet_bowl_d_from_right_wall = 37;
big_pipe_d = 4 * 2.54;
small_drain_pipe_d = 2 * 2.54;

module plumbing(house_sz, front_cut_diag, toilet_cut_d, bedroom_l = 290,wall_t=11, wall_height=260, extra_height=11, roof_angle=20, show_concrete=false)
{
  // Toilet bowl drain pipe
  x1 = house_sz[0] - toilet_cut_d[0] - wall_t - toilet_bowl_d_from_right_wall;
  y1 = toilet_cut_d[1] - toilet_bowl_d_from_back_wall;
  color("Magenta")
  translate([x1,y1,0])
  cylinder(h = pipe_depth_from_floor, d = big_pipe_d);
  
  // Shower drain pipe
  shower_drain_corner_d = 15;
  x2 = house_sz[0] - toilet_cut_d[0] - wall_t - shower_drain_corner_d;
  y2 = wall_t + shower_drain_corner_d;
  color("Magenta")
  translate([x2,y2,0])
  cylinder(h = pipe_depth_from_floor, d = small_drain_pipe_d);

  //dim_scaling = 1.3;
  //hdim(x1, x2, y1, -20, dim_scaling);
}


// For testing
plumbing(house_sz = [515, 410], front_cut_diag = 60, toilet_cut_d = [170, 139], bedroom_l = 290, wall_t=11, wall_height=260, show_concrete=true);
