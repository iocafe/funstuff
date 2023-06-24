use <basefloor.scad> 
use <feet/feet.scad> 
use <cubewall.scad>
use <roof/houseroof.scad>
use <roof/terraceroof.scad>
use <toilet/toilet.scad>
use <masterbedroom/masterbedroom.scad>
use <bedroom/bedroom.scad>
use <storage/pumproom.scad>

show_upper_level = false;
show_roof = false;

// House bottom floor with legs 
house_width = 800;
house_length = 1200;
floor_thickness=20;
wall_thickness=15;
first_foor_height = 280;
upper_level_height = 280;
feet_height=200;
extend_feet_up = first_foor_height + upper_level_height;

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

/* Bottom level floor */
color(base_level_floor_color,base_level_floor_alpha) basefloor(house_width, house_length,floor_thickness); 

/* Bottom level walls */
color(base_level_wall_color,base_level_wall_alpha) cubewall(house_width, house_length, wall_thickness, first_foor_height);

// Bedroom 1
bedroom1_width = house_width/2 - wall_thickness;
bedroom1_length = bedroom1_width*0.9;
bedroom_wall_height = first_foor_height - floor_thickness/2;
translate([-house_length/2 + bedroom1_length/2, -house_width/2+ bedroom1_length/2 + wall_thickness, floor_thickness/2 ]) rotate([0,0,0]) bedroom(bedroom1_width, bedroom1_length, wall_thickness, bedroom_wall_height,  top_level_wall_color, top_level_wall_alpha);

/*  Top level floor */
if (show_upper_level) {
    color(top_level_floor_color,top_level_floor_alpha)
        translate([0, 0, first_foor_height]) 
        basefloor(house_width, house_length,floor_thickness); 
}

/* Upper level */
topfloor_length = house_length - 400;

if (show_upper_level) {
    /* Master bedroom upstairs */
     translate([topfloor_length/2-house_length/2,0,first_foor_height])  masterbedroom(house_width, topfloor_length, wall_thickness, upper_level_height, top_level_wall_color, top_level_wall_alpha);

    /* Upper floor balcony railing */
    color([255/255, 255/255, 255/255],0.8) translate([topfloor_length/2,0,first_foor_height]) cubewall(house_width, house_length-topfloor_length, wall_thickness, 100); 

    /* Upstairs toilet */
    upstairs_toilet_width = 280;
    upstairs_toilet_length = 200;
     translate([house_length/2 - topfloor_length/2+upstairs_toilet_width/2-wall_thickness, -house_width/2 +upstairs_toilet_length/2, first_foor_height +floor_thickness/2]) rotate([0,0,270]) toilet(true, upstairs_toilet_width, upstairs_toilet_length, wall_thickness, 260, top_level_wall_color,top_level_wall_alpha) ;

    /* Upstairs pumproom */
    pumproom_width = house_length - topfloor_length - upstairs_toilet_width + 2*wall_thickness;
    pumproom_length = upstairs_toilet_length;
    color(top_level_wall_color,top_level_wall_alpha) translate([house_length/2 - topfloor_length/2+upstairs_toilet_width+pumproom_width/2-2*wall_thickness, -house_width/2 + pumproom_length/2, first_foor_height +floor_thickness/2]) rotate([0,0,270]) pumproom(pumproom_width, pumproom_length, wall_thickness, 260);
}

/* House roof */
if (show_roof) {
    color(roof_color, roof_alpha) translate([0,0,first_foor_height+upper_level_height]) houseroof(house_width, house_length);
}

/* Upper level ceiling */
if (show_roof) {
color(concrete_ceiling_color, concrete_ceiling_alpha) translate([0, 0, first_foor_height+upper_level_height]) basefloor(house_width, house_length,floor_thickness); 
}

/* Terrace floor with legs */
terrace_width = 400;
terrace_length = 1200;
terrace_fence_height = 100;
terrace_height = 300;
terrace_pos = house_width/2+terrace_width/2 - 1.5*wall_thickness+ 5;
translate([0, terrace_pos, 0]) {color([120/255, 55/255, 55/255],1.0) feet(terrace_width,terrace_length,feet_height, terrace_height);
    
// Terrace floor
color(base_level_floor_color,base_level_floor_alpha)  basefloor(terrace_width, terrace_length,floor_thickness);} 
color(base_level_wall_color,base_level_wall_alpha) translate([0, terrace_pos, 0]) cubewall(terrace_width, terrace_length, wall_thickness, terrace_fence_height);

// Terrace toilet
terrace_toilet_width = 260;
terrace_toilet_length = 200;
/* color(base_level_wall_color,base_level_wall_alpha)  */ translate([-house_length/2+terrace_toilet_length/2, house_width/2+terrace_width/2 + (terrace_width-terrace_toilet_width-2*wall_thickness - 5)/2,, floor_thickness/2]) rotate([0,0,180]) toilet(false, terrace_toilet_width, terrace_toilet_length, wall_thickness, 260, base_level_wall_color,base_level_wall_alpha);

// Terrace storage room
storageroom_width = terrace_width - terrace_toilet_width + wall_thickness;
storageroom_length = terrace_toilet_length;
color(base_level_wall_color,base_level_wall_alpha) translate([-house_length/2 + storageroom_length/2, terrace_pos - storageroom_length/2 - 2*wall_thickness, floor_thickness/2]) rotate([0,0,180]) pumproom(storageroom_width, storageroom_length, wall_thickness, 260);

/* Terrace roof */
if (show_roof) {
    color(roof_color, roof_alpha) translate([0,terrace_pos,first_foor_height]) terraceroof(terrace_width, terrace_length);
}
