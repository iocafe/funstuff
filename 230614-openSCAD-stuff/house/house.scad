use <basefloor.scad> 
use <feet.scad> 
use <cubewall.scad>
use <houseroof.scad>
use <terraceroof.scad>

// House bottom floor with legs 
house_width = 800;
house_length = 1200;
floor_thickness=20;
wall_thickness=15;
first_foor_height = 280;
second_foor_height = 280;
feet_height=200;
extend_feet_up = first_foor_height + second_foor_height;

base_level_wall_color = [255/255, 255/255, 255/255];
top_level_wall_color = [255/255, 255/255, 255/255];
base_level_floor_color = [0.30, 0.10, 0.10];
top_level_floor_color = [0.30, 0.10, 0.10];
concrete_ceiling_color = [1.0,1.0,1.0];
roof_color = [0.8,0.8,0.8];

base_level_wall_alpha = 0.8;
top_level_wall_alpha = 0.8;
base_level_floor_alpha = 1.0;
top_level_floor_alpha = 0.5;
concrete_ceiling_alpha = 0.64;
roof_alpha = 0.3;

color([120/255, 55/255, 55/255],1.0) 
feet(house_width,house_length,feet_height,extend_feet_up);

// Bottom level floor
color(base_level_floor_color,base_level_floor_alpha) basefloor(house_width, house_length,floor_thickness); 

// Bottom level walls
color(base_level_wall_color,base_level_wall_alpha) cubewall(house_width, house_length, wall_thickness, first_foor_height);

// Bottom level floor
color(top_level_floor_color,top_level_floor_alpha)translate([0, 0, first_foor_height]) basefloor(house_width, house_length,floor_thickness); 

// Bottom floor walls
topfloor_length = house_length - 400;
color([255/255, 255/255, 255/255],0.8) translate([topfloor_length/2-house_length/2,0,first_foor_height]) cubewall(house_width, topfloor_length, wall_thickness, first_foor_height);

color([255/255, 255/255, 255/255],0.8) translate([topfloor_length/2,0,first_foor_height]) cubewall(house_width, house_length-topfloor_length, wall_thickness, 100);

// House roof
color(roof_color, roof_alpha) translate([0,0,first_foor_height+second_foor_height]) houseroof(house_width, house_length);

color(concrete_ceiling_color, concrete_ceiling_alpha) translate([0, 0, first_foor_height+second_foor_height]) basefloor(house_width, house_length,floor_thickness); 

// Terrace floor with legs 
terrace_width = 400;
terrace_length = 1200;
terrace_fence_height = 100;
terrace_height = 300;
terrace_pos = house_width/2+terrace_width/2 + 5;
translate([0, terrace_pos, 0]) {color([120/255, 55/255, 55/255],1.0) feet(terrace_width,terrace_length,feet_height, terrace_height);
    
// Terrace floor
color(base_level_floor_color,base_level_floor_alpha)  basefloor(terrace_width, terrace_length,floor_thickness);} 
color(base_level_wall_color,base_level_wall_alpha) translate([0, terrace_pos, 0]) cubewall(terrace_width, terrace_length, wall_thickness, terrace_fence_height);

// Teracce roof
color(roof_color, roof_alpha) translate([0,terrace_pos,first_foor_height]) terraceroof(terrace_width, terrace_length);
