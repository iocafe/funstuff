use <verticalpillar.scad>
use <horizontalpillar.scad>
use <../hdim.scad>

show_horzontal_pillars = true;

vertical_pillar_diam = 24;
vp_r  = vertical_pillar_diam/2;
horizontal_pillar_w = vertical_pillar_diam;
horizontal_pillar_h=30;
up_horizontal_pillar_w = horizontal_pillar_w;
above_floor=265;
below_floor=100;
hor_pillar_floor_d = 30;

module foundation(house_sz, front_cut_diag, toilet_cut_d, bedroom_l = 290,wall_t=11, wall_height=265, extra_height=11, roof_angle=20, show_concrete=false)
{
  z = 0;
  
  x1 = wall_t/2;
  y1 = house_sz[1]-wall_t/2;
  translate([x1, y1, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);

  x2 = house_sz[0] - bedroom_l - wall_t;
  y2 = y1;
  translate([x2, y2, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);

  x3 = house_sz[0] - wall_t/2;
  y3 = y2;
  translate([x3, y3, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);

  x4 = x3;
  y4 = toilet_cut_d[1] + wall_t/2;
  translate([x4, y4, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);

  x5 = x2;
  y5 = y4;
  translate([x5, y5, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);

  x6 = house_sz[0]-toilet_cut_d[0] - wall_t/2;
  y6 = wall_t/2;
  translate([x6, y6, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);

  x7 = front_cut_diag*sqrt(2) + wall_t/2;
  y7 = wall_t/2;
  translate([x7, y7, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);

  x8 = wall_t/2;
  y8 = front_cut_diag*sqrt(2) + wall_t/2;
  translate([x8, y8, z])
  verticalpillar(above_floor, below_floor, vertical_pillar_diam, show_concrete);
  
  dim_scaling = 1.6;
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

  if (show_horzontal_pillars) {  
    for (i=[0,1]) {
      up = i == 0 ? -hor_pillar_floor_d : wall_height;
      hp_w = i == 0 ? horizontal_pillar_w : up_horizontal_pillar_w;
      hp_h = horizontal_pillar_h;
      
      translate([0,0,up]) {
        translate([0,y1,0]) {
          horizontalpillar(x1+vp_r, x2-vp_r, hp_w, hp_h, show_concrete); 
          horizontalpillar(x2+vp_r, x3-vp_r, hp_w, hp_h, show_concrete); 
        }
        translate([x1,0,0]) 
        rotate([0,0,90])
        horizontalpillar(y8+vp_r, y1-vp_r, hp_w, hp_h, show_concrete); 

        translate([x3,0,0]) 
        rotate([0,0,90])
        horizontalpillar(y4+vp_r, y3-vp_r, hp_w, hp_h, show_concrete); 

        translate([x2,0,0]) 
        rotate([0,0,90])
        horizontalpillar(y5+vp_r, y2-vp_r, hp_w, hp_h, show_concrete); 

        translate([0,y7,0]) 
        horizontalpillar(x7+vp_r, x6-vp_r, hp_w, hp_h, show_concrete); 

        translate([0,y4,0]) 
        horizontalpillar(x5+vp_r, x4-vp_r, hp_w, hp_h, show_concrete); 

        translate([x6,0,0]) 
        rotate([0,0,90])
        horizontalpillar(y6+vp_r, y5-vp_r, hp_w, hp_h, show_concrete); 
     
        translate([x2,0,0]) 
        rotate([0,0,90])
        horizontalpillar(y6+vp_r, y5-vp_r, hp_w, hp_h, show_concrete); 

        m = front_cut_diag/sqrt(2) + wall_t/4;
        half_l = front_cut_diag- wall_t/4;
      
        translate([m,m,0]) 
        rotate([0,0,-45])
        horizontalpillar(-half_l, half_l, hp_w, hp_h, show_concrete); 
      }
    }
  }
}


// For testing
foundation(house_sz = [515, 410], front_cut_diag = 60, toilet_cut_d = [170, 139], bedroom_l = 290, wall_t=11, wall_height=265, show_concrete=true);
