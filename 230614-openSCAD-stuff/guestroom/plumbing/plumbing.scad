use <../hdim.scad>
use <pipeangle.scad>

pipe_depth_from_floor = 25;
toilet_bowl_d_from_back_wall = 30;
toilet_bowl_d_from_right_wall = 37;
big_pipe_d = 4 * 2.54;
small_drain_pipe_d = 2 * 2.54;

ppr_d = 3.2;
ppr_curve_r = 2.3;
shower_water_d = 35;
shower_water_z = 60;
shower_pipe_under_floor = 20;

sink_water_z = 50;
sink_pipe_under_floor = 20;
sink_water_d = 20;

module plumbing(house_sz, front_cut_diag, toilet_cut_d, bedroom_l = 290,wall_t=11, wall_height=265, extra_height=11, roof_angle=20, show_concrete=false)
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
    
  // Shower WATER pipe
  x3 = house_sz[0] - toilet_cut_d[0] - 0.75 * wall_t;
  y3 = 0.5*wall_t + shower_water_d;
  z3 = shower_water_z;
  translate([x3, y3, z3])
  {
      rotate([90,0,0])
      ppr90();
      
      pipe3_l = z3 
        + shower_pipe_under_floor
        - 2*ppr_curve_r; 
      
      translate([0,0,
        -pipe3_l+ppr_curve_r])
      cylinder(d = ppr_d, 
        h = pipe3_l, $fn=23);
 
      translate([0,0,
        -pipe3_l+ppr_curve_r])
      rotate([-90,0,180])
      ppr90();
      
      pipe3b_l = 20;
      
      translate([0,0,
        -pipe3_l])
      rotate([0,90,0])
      cylinder(d = ppr_d, 
        h = pipe3b_l, $fn=23);
  }

  // Sink WATER pipe
  x4 = house_sz[0] - bedroom_l - 0.75 * wall_t;
  y4 = toilet_cut_d[1] - 0.5*wall_t - sink_water_d;
  z4 = sink_water_z;
  translate([x4, y4, z4])
  {
      rotate([90,0,180])
      ppr90();
      
      pipe4_l = z4 
        + sink_pipe_under_floor
        - 2*ppr_curve_r; 
      
      translate([0,0,
        -pipe4_l+ppr_curve_r])
      cylinder(d = ppr_d, 
        h = pipe4_l, $fn=23);
 
      translate([0,0,
        -pipe4_l+ppr_curve_r])
      rotate([-90,0,180])
      ppr90();
      
      pipe4b_l = 140;
      
      translate([0,0,
        -pipe4_l])
      rotate([0,90,0])
      cylinder(d = ppr_d, 
        h = pipe4b_l, $fn=23);
  }

}


// For testing
plumbing(house_sz = [515, 410], front_cut_diag = 60, toilet_cut_d = [170, 139], bedroom_l = 290, wall_t=11, wall_height=265, show_concrete=true);
