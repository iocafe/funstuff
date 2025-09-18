use <../hdim.scad>

drain_corner_rebar_d = 1.2;
drain_loop_rebar_d = 0.8;

module drain_bar(length=100,diam=1,c = "Red") 
{
    color(c) {
      cylinder(h=length, d=diam, center=true, $fn=20);
    }
}

module drain_loop(diam1=10,diam2=20,c = "Red") 
{
  corner_rebarb_d = drain_corner_rebar_d;
  loop_rebarb_d = drain_loop_rebar_d;
  dx = (diam1+loop_rebarb_d)/2;
  lx = diam1 + 2*loop_rebarb_d;
  dy = (diam2+loop_rebarb_d)/2;
  ly = diam2 + 2*loop_rebarb_d;
  
  translate([dx,0,0]) 
  rotate([90,0, 0])
  drain_bar(ly, loop_rebarb_d, c);

  translate([-dx,0,0]) 
  rotate([90,0, 0])
  drain_bar(ly, loop_rebarb_d, c);

  translate([0,-dy,0]) 
  rotate([90,0, 90])
  drain_bar(lx, loop_rebarb_d, c);
}

module drain_welded_lock(diam1=10,diam2=20,cement_edge_d=2, c = "Red") 
{
  rebarb_d = drain_corner_rebar_d;
  dx = diam1/2;
  sdx = dx + rebarb_d;
  lx = diam1 + 2 * cement_edge_d;
  adx = (diam1 - rebarb_d)*sqrt(2);
  dy = diam2/2;
  sdy = dy + rebarb_d;
  ly = diam2 + 2 * cement_edge_d;
  ady = (diam2 - rebarb_d)*sqrt(2);
  
  translate([sdx,0,0]) 
  rotate([90,0, 0])
  drain_bar(ly, rebarb_d, c);
    
  translate([-sdx,0,0]) 
  rotate([90,0, 0])
  drain_bar(ly, rebarb_d, c);

  translate([0,-sdy,0]) 
  rotate([90,0, 90])
  drain_bar(lx, rebarb_d, c);

  translate([dx,0,diam2/2]) 
  rotate([45, 0, 0])
  drain_bar(ady, rebarb_d, c);

  translate([-dx,0,diam2/2]) 
  rotate([-45, 0, 0])
  drain_bar(ady, rebarb_d, c);

  translate([0,-diam2/2,diam1/2]) 
  rotate([-45, 0, 90])
  drain_bar(adx, rebarb_d, c);
}

module drain_channel(length=287, diam1=20, diam2=28, n_loops=14, cement_edge_d=1, c = "Red") 
{
  dx = diam1/2;
  dy = diam2/2;
  corner_rebar_d = drain_corner_rebar_d;
  loop_rebarb_d = drain_loop_rebar_d;
  
  translate([dx,dy,0]) 
  drain_bar(length, corner_rebar_d, c);
  translate([dx,-dy,0]) 
  drain_bar(length, corner_rebar_d, c);
  translate([-dx,dy,0]) 
  drain_bar(length, corner_rebar_d, c);
  translate([-dx,-dy,0]) 
  drain_bar(length, corner_rebar_d, c);
  
  l = length-2*loop_rebarb_d;
  step = l/(n_loops-1);
  for (i=[0:n_loops-1]) {
    x = -l/2 + i*step;
    
    translate([0,0,x])
    drain_loop(diam1+corner_rebar_d, diam2+corner_rebar_d, "Orange");
  }

  // Welded locks
  drain_welded_lock(diam1,diam2,cement_edge_d,c);
  weld_end_d = 40;
  translate([0,0,-length/2 + weld_end_d])
  drain_welded_lock(diam1,diam2,cement_edge_d,c);
  translate([0,0,length/2 - weld_end_d])
  rotate([0,180,0])
  drain_welded_lock(diam1,diam2,cement_edge_d,c);
  
  loop_dx = diam1 + corner_rebar_d + 2*drain_loop_rebar_d;
  loop_dy = diam2 + corner_rebar_d + drain_loop_rebar_d;
  
  loop_len = loop_dx + 2 * loop_dy;
 
  color("blue")
  translate([0,30,0])
  rotate([90,90,90])
  text (str("loop: w=", loop_dx, ", h=", loop_dy, ", len=", loop_len), halign="center", valign="center");
  
  color("green")
  translate([0,50,0])
  rotate([90,90,90])
  text ("lengths: 590cm, 352cm and 287cm", halign="center", valign="center");
}


drain_channel();

