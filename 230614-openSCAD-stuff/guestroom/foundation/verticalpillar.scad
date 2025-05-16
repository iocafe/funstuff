use <reinforcement.scad>
use <../hdim.scad>

reinforcement_indent = 5.2;
finishing_thickness = 2;
reinforcement_step = 15;

module verticalpillar(above_floor=260, below_floor=100, diam=24, show_concrete=true) 
{
  l = above_floor+below_floor;
  d = diam - 2*reinforcement_indent;
  cement_edge_d = reinforcement_indent-finishing_thickness;
  n_reinforcement_loops = round(l/reinforcement_step+1);
  
  translate([0,0,l/2-below_floor])
  {
    pillar_reinforement(l, d, d, n_reinforcement_loops, cement_edge_d); 

    if (show_concrete) {
      color([0.5,0.5,1,0.3])
      cube ([diam-2*finishing_thickness, diam-2*finishing_thickness, l], center=true); 
      color([0.5,1,1,0.3])
      cube ([diam, diam, l], center=true); 
    }
  }
}


verticalpillar();

