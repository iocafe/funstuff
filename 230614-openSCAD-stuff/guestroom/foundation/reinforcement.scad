use <../hdim.scad>

pillar_corner_rebar_d = 1.2;
pillar_loop_rebar_d = 0.8;

module reinforement_bar(length=100,diam=1,c = "Red") 
{
    color(c) {
      cylinder(h=length, d=diam, center=true, $fn=20);
    }
}

module pillar_reinforement_loop(diam1=10,diam2=20,c = "Red") 
{
  corner_rebarb_d = pillar_corner_rebar_d;
  loop_rebarb_d = pillar_loop_rebar_d;
  dx = (diam1+loop_rebarb_d)/2;
  lx = diam1 + 2*loop_rebarb_d;
  dy = (diam2+loop_rebarb_d)/2;
  ly = diam2 + 2*loop_rebarb_d;
  
  translate([dx,0,0]) 
  rotate([90,0, 0])
  reinforement_bar(ly, loop_rebarb_d, c);

  translate([0,dy,0]) 
  rotate([90,0, 90])
  reinforement_bar(lx, loop_rebarb_d, c);
    
  translate([-dx,0,0]) 
  rotate([90,0, 0])
  reinforement_bar(ly, loop_rebarb_d, c);

  translate([0,-dy,0]) 
  rotate([90,0, 90])
  reinforement_bar(lx, loop_rebarb_d, c);
}

module pillar_welded_lock(diam1=10,diam2=20,c = "Red") 
{
  rebarb_d = pillar_corner_rebar_d;
  dx = diam1/2;
  lx = diam1 - rebarb_d;
  dy = diam2/2;
  adx = lx*sqrt(2);
  ly = diam2 - rebarb_d;
  ady = ly*sqrt(2);
  
  translate([dx,0,0]) 
  rotate([90,0, 0])
  reinforement_bar(ly, rebarb_d, c);

  translate([0,dy,0]) 
  rotate([90,0, 90])
  reinforement_bar(lx, rebarb_d, c);
    
  translate([-dx,0,0]) 
  rotate([90,0, 0])
  reinforement_bar(ly, rebarb_d, c);

  translate([0,-dy,0]) 
  rotate([90,0, 90])
  reinforement_bar(lx, rebarb_d, c);

  translate([dx,0,ly/2+rebarb_d/2]) 
  rotate([45, 0, 0])
  reinforement_bar(ady, rebarb_d, c);

  translate([0,dy,lx/2+rebarb_d/2]) 
  rotate([45, 0, 90])
  reinforement_bar(adx, rebarb_d, c);

  translate([-dx,0,ly/2+rebarb_d/2]) 
  rotate([-45, 0, 0])
  reinforement_bar(ady, rebarb_d, c);

  translate([0,-dy,lx/2+rebarb_d/2]) 
  rotate([-45, 0, 90])
  reinforement_bar(adx, rebarb_d, c);
}

module pillar_reinforement(length=130, diam1=10, diam2=20, n_loops=6, c = "Red") 
{
  dx = diam1/2;
  dy = diam2/2;
  corner_rebar_d = pillar_corner_rebar_d;
  loop_rebarb_d = pillar_loop_rebar_d;
  
  translate([dx,dy,0]) 
  reinforement_bar(length, corner_rebar_d, c);
  translate([dx,-dy,0]) 
  reinforement_bar(length, corner_rebar_d, c);
  translate([-dx,dy,0]) 
  reinforement_bar(length, corner_rebar_d, c);
  translate([-dx,-dy,0]) 
  reinforement_bar(length, corner_rebar_d, c);
  
  l = length-2*loop_rebarb_d;
  step = l/(n_loops-1);
  for (i=[0:n_loops-1]) {
    x = -l/2 + i*step;
    
    translate([0,0,x])
    pillar_reinforement_loop(diam1+corner_rebar_d, diam2+corner_rebar_d, "Orange");
  }

  // Welded locks
  pillar_welded_lock(diam1,diam2,c);
  weld_end_d  = 10;
  translate([0,0,-length/2 + weld_end_d])
  pillar_welded_lock(diam1,diam2,c);
  translate([0,0,length/2 - weld_end_d])
  rotate([180,0,0])
  pillar_welded_lock(diam1,diam2,c);
}


pillar_reinforement();

