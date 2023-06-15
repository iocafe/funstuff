use <basefloor.scad> 
use <feet.scad> 
use <cubewall.scad>
use <houseroof.scad>

// House bottom floor with legs 
house_width = 800;
house_length = 1200;
floor_thickness=20;
wall_thickness=15;
first_foor_height = 280;
second_foor_height = 280;
feet_height=200;
extend_feet_up = first_foor_height + second_foor_height;

color([120/255, 55/255, 55/255],1.0) 
feet(house_width,house_length,feet_height,extend_feet_up);

basefloor(house_width, house_length,floor_thickness); 

color([255/255, 255/255, 255/255],0.8) cubewall(house_width, house_length, wall_thickness, first_foor_height);
translate([0, 0, first_foor_height]) basefloor(house_width, house_length,floor_thickness); 

topfloor_length = house_length - 400;
color([255/255, 255/255, 255/255],0.8) translate([topfloor_length/2-house_length/2,0,first_foor_height]) cubewall(house_width, topfloor_length, wall_thickness, first_foor_height);

color([255/255, 255/255, 255/255],0.8) translate([topfloor_length/2,0,first_foor_height]) cubewall(house_width, house_length-topfloor_length, wall_thickness, 100);

translate([0,0,first_foor_height+second_foor_height]) houseroof(house_width, house_length);

translate([0, 0, first_foor_height+second_foor_height]) basefloor(house_width, house_length,floor_thickness); 

// Terrace floor with legs 
terrace_width = 400;
terrace_length = 1200;
terrace_fence_height = 100;
terrace_height = 300;
terrace_pos = house_width/2+terrace_width/2 + 5;
translate([0, terrace_pos, 0]) {color([120/255, 55/255, 55/255],1.0) feet(terrace_width,terrace_length,feet_height, terrace_height);
basefloor(terrace_width, terrace_length,floor_thickness);} 
color([255/255, 255/255, 255/255],0.8) translate([0, terrace_pos, 0]) cubewall(terrace_width, terrace_length, wall_thickness, terrace_fence_height);
