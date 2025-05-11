use <reinforcement.scad>
use <../hdim.scad>

reinforcement_indent = 2;
n_reinforcement_loops = 20;

module verticalpillar(above_floor=260, below_floor=100, diam=16, show_concrete=true) 
{
  l = above_floor+below_floor;
  d = diam - 2*reinforcement_indent;
 
  translate([0,0,l/2-below_floor])
  {
    pillar_reinforement(l, d, d, n_reinforcement_loops); 

    if (show_concrete) {
      color([0.5,1,1,0.3])
      cube ([diam, diam, l], center=true); 
    }
  }
}


verticalpillar();

