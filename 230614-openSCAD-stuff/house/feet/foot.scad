module foot(p, feet_thickness=20, feet_height=200,extend_up=30) {
  
translate([p[0],p[1],-feet_height/2+extend_up/2]) cube([feet_thickness,feet_thickness,feet_height+extend_up],center=true);
}

// foot(p=[1,2,3]);