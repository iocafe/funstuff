use <verticalpillar.scad>
use <../hdim.scad>

vertical_pillar_diam = 16;
above_floor=260;
below_floor=100;

module foundation(house_sz, front_cut_diag, toilet_cut_d, bedroom_l = 290,wall_t=11, wall_height=260, extra_height=11, roof_angle=20, show_concrete=false)
{
  z = 0;
  
  x1 = wall_t/2;
  y1 = house_sz[1]-wall_t/2;
  translate([x1, y1, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);

  x2 = house_sz[0] - bedroom_l - wall_t;
  y2 = y1;
  translate([x2, y2, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);

  x3 = house_sz[0] - wall_t/2;
  y3 = y2;
  translate([x3, y3, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);

  x4 = x3;
  y4 = toilet_cut_d[1] + wall_t/2;
  translate([x4, y4, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);

  x5 = x2;
  y5 = y4;
  translate([x5, y5, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);

  x6 = house_sz[0]-toilet_cut_d[0] - wall_t/2;
  y6 = wall_t/2;
  translate([x6, y6, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);

  x7 = front_cut_diag*sqrt(2) + wall_t/2;
  y7 = wall_t/2;
  translate([x7, y7, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);

  x8 = wall_t/2;
  y8 = front_cut_diag*sqrt(2) + wall_t/2;
  translate([x8, y8, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete=true);
  
  dim_scaling = 1.3;
  hdim(x1, x2, y1, -20, dim_scaling);
  hdim(x1, x3, y1, -32, dim_scaling);
  hdim(x1, x7, y7, -100, dim_scaling);
  hdim(x1, x6, y6, -112, dim_scaling);
  hdim(x1, x5, y5, -22, dim_scaling);
  hdim(x1, x4, y4, -34, dim_scaling);
  rotate([0,0,90]) hdim(y8, y1, x1, -20, dim_scaling);
  rotate([0,0,90]) hdim(y7, y1, x1, -32, dim_scaling);
  rotate([0,0,90]) hdim(y6, y2, -x7, 22, dim_scaling);
  rotate([0,0,90]) hdim(y5, y2, -x5, 22, dim_scaling);
  rotate([0,0,90]) hdim(y4, y2, -x4, 22, dim_scaling);
}


// For testing
foundation(house_sz = [515, 410], front_cut_diag = 60, toilet_cut_d = [177, 156], bedroom_l = 290, wall_t=11, wall_height=260, show_concrete=true);
