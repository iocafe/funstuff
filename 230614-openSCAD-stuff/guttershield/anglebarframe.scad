use <hdim.scad> 

default_bar_diam = 3.8;
default_bar_t  = 0.3;

module anglebarframe(length = 140, width = 70, 
    bar_diam = default_bar_diam, 
    bar_t = default_bar_t, 
    explode=false, 
    explode_d = 20, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0],
    flap_outwards = false)
{
    d = explode ? explode_d : 0;
    out_rotate = flap_outwards ? 180 : 0;
      
    rotate([0,180,0])
    {
        translate([-length/2,-width/2-d,0]) 
        anglebar_helper(length, bar_diam, bar_t, c2, flap_outwards);
       
        translate([length/2,width/2+d,0]) 
        rotate([0,0,180]) 
        anglebar_helper(length, bar_diam, bar_t, c1, flap_outwards);
        //if (explode) {
            hdim(-length/2, length/2, width/2+d, -9);
        //}
            
        translate([d+length/2,-width/2,0]) 
        rotate([0,0,90]) 
        anglebar_helper(width, bar_diam, bar_t, c2, flap_outwards);
        //if (explode) {
            rotate([0,0,90]) 
            hdim(-width/2, width/2, length/2+d, -9);
        //}
        
        translate([-length/2-d,width/2,0]) 
        rotate([0,0,-90])
        anglebar_helper(width, bar_diam, bar_t, c1, flap_outwards);
    }
}        

module anglebar_helper(length, 
    bar_diam, 
    bar_t,
    c,
    flap_outwards)
{
  line_w = 0.1;
  p=[[0,0],
      [bar_diam, bar_diam],
      [length-bar_diam, bar_diam],
      [length, 0], [0,0]];

  p2=[[line_w*2.5,line_w],
      [bar_diam+line_w*0.5, bar_diam-line_w],
      [length-bar_diam-line_w*0.5, bar_diam-line_w],
      [length-line_w*2.5, line_w], [line_w*2.5,line_w]];

  small = 0.012;

  color(c) 
  linear_extrude(bar_t) 
  polygon(p);

  translate([0,0,-small/2])
  color("WhiteSmoke") 
  linear_extrude(bar_t+small) 
  polygon(p2);

  if (flap_outwards) {
      translate([bar_diam-bar_t, bar_diam-bar_t, bar_t])
      color(c) 
      cube([length-2*(bar_diam-bar_t), bar_t, bar_diam-bar_t]);
      
      translate([bar_diam-bar_t+line_w, bar_diam-bar_t-small/2, line_w])
      color("WhiteSmoke") 
      cube([length-2*(bar_diam-bar_t)-2*+line_w, bar_t+small, bar_diam-2*+line_w]);
  }
  else {
      translate([0, 0, bar_t])
      color(c) 
      cube([length, bar_t, bar_diam-bar_t]);

      translate([line_w, -small/2, line_w])
      color("WhiteSmoke") 
      cube([length-2*line_w, bar_t+small, bar_diam-2*line_w]); 
  } 
}   


anglebarframe(explode=true, flap_outwards=true);