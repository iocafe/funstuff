use <basefloor.scad> 
use <feet/feet.scad> 
use <cubewall.scad>
use <roof/houseroof.scad>
use <roof/terraceroof.scad>
use <toilet/toilet.scad>
use <masterbedroom/masterbedroom.scad>
use <bedroom/bedroom.scad>
use <kitchen/kitchen.scad>
use <terrace/terrace.scad>
use <storage/pumproom.scad>
use <stairs/longstairs.scad>
use <stairs/longstairs2.scad>
use <stairs/stairbox.scad>

show_upper_level = true;
show_roof = false;

/* Generic house parameters */
house_width = 800;
house_length = 1200;
floor_thickness=20;
wall_thickness=15;
first_foor_height = 280;
upper_level_height = 280;
feet_height=200;
extend_feet_up = first_foor_height + upper_level_height;

window_y = 90;
window_w = 120;
toilet_window_w = 80 + 5.3;
window_h = 140;

base_level_wall_color = [255/255, 255/255, 255/255];
top_level_wall_color = [255/255, 255/255, 255/255];
base_level_floor_color = [0.20, 0.15, 0.15];
top_level_floor_color = [0.20, 0.15, 0.15];
concrete_ceiling_color = [1.0,1.0,1.0];
roof_color = [0.8,0.8,0.8];

base_level_wall_alpha = 0.8;
top_level_wall_alpha = 0.8;
base_level_floor_alpha = 1.0;
top_level_floor_alpha = 0.85;
concrete_ceiling_alpha = 0.74;
roof_alpha = 0.3;

color([120/255, 55/255, 55/255],1.0) 
feet(house_width,house_length,feet_height,extend_feet_up);

    /* Bottom level floor */
    color(base_level_floor_color,base_level_floor_alpha) basefloor(house_width, house_length,floor_thickness); 
    
    /* Bedroom 1 */
    bedroom1_width = house_width/2 + 50;
    bedroom1_length = house_length * 0.41;
    bedroom_wall_height = first_foor_height - floor_thickness/2;
    translate([-house_length/2 + bedroom1_length/2, 
        -house_width/2+ bedroom1_width/2, 
        floor_thickness/2 ]) 
    rotate([0,0,0]) 
    bedroom(bedroom1_width/2-75, 1, 
        bedroom1_width, bedroom1_length, 
        wall_thickness, bedroom_wall_height, top_level_wall_color,
        top_level_wall_alpha, [1.0,0.7,0.7]);
    
    /* Bedroom 2 */
    bedroom2_width = house_width - bedroom1_width;
    bedroom2_length = bedroom1_length;
    translate([-house_length/2 + bedroom2_length/2,
        -house_width/2 + bedroom2_width/2 
        + bedroom1_width - wall_thickness/2, 
        floor_thickness/2 ]) rotate([0,0,0]) 
    bedroom(-60, 2, 
        bedroom2_width + wall_thickness, 
        bedroom2_length, wall_thickness, 
        bedroom_wall_height, 
        top_level_wall_color, top_level_wall_alpha);
    
    /* Bedroom 3 */
    bedroom3_width = house_width/2-80;
    bedroom3_length = 0.26*house_length;
    translate([-house_length/2 + bedroom3_length/2 + bedroom1_length - wall_thickness, - house_width/2+ bedroom3_width/2, floor_thickness/2 ]) rotate([0,0,0]) 
    bedroom(0, 3, bedroom3_width, bedroom3_length, wall_thickness, bedroom_wall_height,  top_level_wall_color, top_level_wall_alpha, [0.6,0.9,0.7]);

    /* Kitchen */
    kitchen_width = house_width;
    kitchen_length = house_length - bedroom1_length;
    front_wall_len = kitchen_length;
    back_wall_len = kitchen_length - bedroom3_length;
    translate([house_length/2 - kitchen_length/2, 0, floor_thickness/2]) 
    kitchen(kitchen_width, kitchen_length, 
        front_wall_len, back_wall_len + wall_thickness, 
        wall_thickness, bedroom_wall_height, top_level_wall_color, top_level_wall_alpha, [0.9,0.3,0.3]);
    
    /*  Top level floor and stair box */
    if (show_upper_level) {
        stair_hole_width = 140;
        stair_hole_length = 370;
        stair_hole_dx = -295;
        stair_hole_dy = house_width/2 
            - stair_hole_width/2;
            // - wall_thickness;
        
        difference() {
            translate([0, 0, first_foor_height])
            color(top_level_floor_color,
                top_level_floor_alpha)
            basefloor(house_width - 0.2, 
                house_length - 0.2,
                floor_thickness); 
            
            /* Hole in floor for stairs */
            translate([stair_hole_dx, 
                stair_hole_dy, 
                first_foor_height])
            color(top_level_floor_color,
                top_level_floor_alpha)       
            cube([stair_hole_length,
                stair_hole_width, 
                floor_thickness+1], center=true);
        }

        /* Stair box */
        translate([stair_hole_dx + wall_thickness/2,
            stair_hole_dy - wall_thickness/2,
            first_foor_height])
        stairbox(stair_hole_width + wall_thickness,
            stair_hole_length + wall_thickness,
            wall_thickness, 
            upper_level_height,
            top_level_wall_color,
            top_level_wall_alpha);
        
        /* Stairs to attick */
        stair_width = 100;
        stair_length = 400;
        stair_height = upper_level_height 
            - floor_thickness/2 - 20;
        stair_n_steps = 13;
        translate([-house_length/2 + stair_width/2 + wall_thickness, 
            stair_length/2 - 120,
            first_foor_height  + floor_thickness/2]) 
            rotate([0,0,-90])
        longstairs(stair_length, stair_height, stair_width, stair_n_steps);
    }

/* Upper level */
topfloor_length = house_length - 400;
topfloor_back_terrace_width = 120;
topfloor_side_terrace_width = 80;

if (show_upper_level) {
    /* Master bedroom upstairs */
    translate([topfloor_length/2-house_length/2 + topfloor_back_terrace_width/2,
    topfloor_side_terrace_width/2,
    first_foor_height])  
    masterbedroom(house_width - topfloor_side_terrace_width,
        topfloor_length - topfloor_back_terrace_width,
        wall_thickness, upper_level_height,
        top_level_wall_color, top_level_wall_alpha);

    /* Upper level balcony railing */
    /* color([255/255, 255/255, 255/255],0.8) translate([topfloor_length/2,0,first_foor_height]) cubewall(house_width, house_length-topfloor_length, wall_thickness, 100); */ 
    color([255/255, 255/255, 255/255],0.8) 
    translate([0,0,first_foor_height]) 
    cubewall(house_width, house_length,
        wall_thickness, 100); 
    
    /* Upstairs toilet */
    upstairs_toilet_width = 280;
    upstairs_toilet_length = 200;
     translate([house_length/2 - topfloor_length/2+upstairs_toilet_width/2-wall_thickness, -house_width/2 + upstairs_toilet_length/2 
    + topfloor_side_terrace_width, first_foor_height + floor_thickness/2]) rotate([0,0,270]) toilet(true, upstairs_toilet_width, upstairs_toilet_length, wall_thickness, 260, top_level_wall_color,top_level_wall_alpha) ;

    /* Upstairs pumproom */
    pumproom_width = house_length - topfloor_length 
        - upstairs_toilet_width + 2*wall_thickness;
    pumproom_length = upstairs_toilet_length;
    translate([house_length/2 - topfloor_length/2
        + upstairs_toilet_width 
        + pumproom_width/2
        - 2*wall_thickness, 
        -house_width/2 
        + pumproom_length/2 
        + topfloor_side_terrace_width, first_foor_height +floor_thickness/2]) rotate([0,0,270]) pumproom(pumproom_width, pumproom_length, wall_thickness, 260, top_level_wall_color,top_level_wall_alpha);
}

    /* House roof */
    if (show_roof) {
        color(roof_color, roof_alpha)
        translate([0,0,
            first_foor_height + upper_level_height])
        rotate([0,0,180])
        houseroof(house_width, house_length);
    }
    
    /* Upper level ceiling */
    if (show_roof) {
        translate([topfloor_length/2
            - house_length/2 
            + topfloor_back_terrace_width/2, 
            topfloor_side_terrace_width/2, 
            first_foor_height
            + upper_level_height]) 
        color(concrete_ceiling_color, concrete_ceiling_alpha) 
        basefloor(house_width - topfloor_side_terrace_width,
            topfloor_length - topfloor_back_terrace_width,
            floor_thickness); 
    }

/* Terrace floor with legs */
terrace_width = 400;
terrace_length = 1200;
terrace_fence_height = 100;
terrace_height = 300;
terrace_pos = house_width/2+terrace_width/2 - 1.0*wall_thickness;
translate([0, terrace_pos, 0]) {color([120/255, 55/255, 55/255],1.0) feet(terrace_width,terrace_length,feet_height, terrace_height);
    
// Terrace floor
color(base_level_floor_color,base_level_floor_alpha)  basefloor(terrace_width, terrace_length,floor_thickness);} 

// Terrace toilet
terrace_toilet_width = 250;
terrace_toilet_length = 200;
translate([-house_length/2+terrace_toilet_length/2, house_width/2+terrace_width/2 + (terrace_width-terrace_toilet_width-2*wall_thickness)/2, floor_thickness/2]) rotate([0,0,180]) toilet(false, terrace_toilet_width, terrace_toilet_length, wall_thickness, 260, base_level_wall_color,base_level_wall_alpha);

// Terrace storage room
storageroom_width = terrace_width - terrace_toilet_width + wall_thickness;
storageroom_length = terrace_toilet_length;
translate([-house_length/2 + storageroom_length/2, terrace_pos - storageroom_width/2 - 2.5*wall_thickness, floor_thickness/2]) rotate([0,0,180]) pumproom(storageroom_width, storageroom_length, wall_thickness, 260, base_level_wall_color,base_level_wall_alpha);

/* Terrace */
translate([terrace_toilet_length/2, terrace_pos, 0]) terrace(terrace_width, terrace_length - terrace_toilet_length, wall_thickness, terrace_fence_height, base_level_wall_color, base_level_wall_alpha);

/* Terrace roof */
if (show_roof) {
    color(roof_color, roof_alpha) 
    translate([0,terrace_pos,first_foor_height]) 
    terraceroof(terrace_width, terrace_length);
}

    /* Side sunshade roof */
    if (show_roof) {
        color(roof_color, roof_alpha) 
        translate([0,
            -house_width/2 - 25,
            first_foor_height]) 
        rotate([0,0,180])
        terraceroof(50, house_length - 300);
    }

    /* Back sunshade roof */
    if (show_roof) {
        color(roof_color, roof_alpha) 
        translate([-house_length/2, 
            terrace_width/2 - 25,
            first_foor_height]) 
        rotate([0,0,90])
        terraceroof(50, 
            house_width + terrace_width - 300);
    }

    /* Stairs to upper level */
    stair_width2 = 120;
    stair_length2 = 430;
    stair_height2 = first_foor_height - floor_thickness/2;
    stair_n_steps2 = 15;
    translate([-150,
        house_width/2 - stair_width2/2 - 1.5*wall_thickness,
        floor_thickness/2]) 
    rotate([0,0,180])
    longstairs2(stair_length2, stair_height2, stair_width2, stair_n_steps2);

/*    translate([-360,200,290]) cube([450, 10, 10], center=true);
translate([-400,225,290]) cube([10, 310, 10], center=true); */
