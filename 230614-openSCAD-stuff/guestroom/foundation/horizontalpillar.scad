use <reinforcement.scad>
use <../hdim.scad>

reinforcement_indent = 2;
reinforcement_step = 18;

module horizontalpillar(x1=20, x2=200, w=16, h=25, show_concrete=true) 
{
  l = x2 - x1;
  n_reinforcement_loops = round(l/reinforcement_step+1);
  translate([x1+(x2-x1)/2,0,-h/2])
  {
    rotate([0,90,0])
    pillar_reinforement(l, h-2*reinforcement_indent, w-2*reinforcement_indent, n_reinforcement_loops); 

    if (show_concrete) {
      color([0.5,1,1,0.3])
      cube ([l, w, h], center=true); 
    }
  }
}


horizontalpillar();

