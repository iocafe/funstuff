use <basicdoor.scad>
use <frontdoor.scad>
use <arcwindowhole.scad> 
use <kingwindow.scad>
use <hdim.scad>

// Animation mode, 0 = off, 1 = doors, 2 = windows, 3=doors+windows;
animation_mode=3;

use_arc_windows = true;
one_big_arc_window = true;

window_1_move = 120;
window_1a_move = 190;
window_1b_move = 70;
window_2_move = 130;
window_3_move = 75;
window_4_move = 70;

window_5_move = 80;
window_6_move = 220;
window_7_move = 160;

arc_window_1_move = 170;
arc_window_2_move = 175;
arc_window_3_move = 305;

arc_front_door_w = 90;
front_door_w = 95.4;
            
bedroom_door_move = 210;
bathroom_door_move = 105;

module walls(house_sz, front_cut_diag, toilet_cut_d, bedroom_l = 240,wall_t=15, wall_height=260, transparent_concrete=false)
{
    // Colors
    wall_color=transparent_concrete 
        ? [0.3,0.3,0.3,0.12] : [250/255, 150/255, 58/255, 1.0];
    wall_color2=transparent_concrete 
        ? [0.3,0.3,0.3,0.3] : [250/255, 150/255, 58/255, 1.0];
    paint_the_rooms = transparent_concrete 
        ? [0.3,0.3,0.3,0.3] : [255/255, 255/255, 255/255, 1.0];
    
    c = sqrt(2) * front_cut_diag;
    sz = house_sz;
    exteriorpoints = [ 
        [0, sz[1]], 
        [sz[0], sz[1]],
        [sz[0], toilet_cut_d[1]],
        [sz[0] - toilet_cut_d[0], toilet_cut_d[1]],
        [sz[0] - toilet_cut_d[0], 0],
        [c, 0],
        [0, c]];

    interiorpoints = [ 
        [wall_t, sz[1] - wall_t], 
        [sz[0] - wall_t, sz[1] - wall_t],
        [sz[0] - wall_t, toilet_cut_d[1] + wall_t],
        [sz[0] - toilet_cut_d[0] - wall_t, toilet_cut_d[1] + wall_t],
        [sz[0] - toilet_cut_d[0] - wall_t, wall_t],
        [c + wall_t/sqrt(2), wall_t],
        [wall_t, c+ wall_t/sqrt(2)]];
 
    painted_wall_t = wall_t + 0.1; 
    paintpoints = [ 
        [painted_wall_t, sz[1] - painted_wall_t], 
        [sz[0] - painted_wall_t, sz[1] - painted_wall_t],
        [sz[0] - painted_wall_t, toilet_cut_d[1] + painted_wall_t],
        [sz[0] - toilet_cut_d[0] - painted_wall_t, toilet_cut_d[1] + painted_wall_t],
        [sz[0] - toilet_cut_d[0] - painted_wall_t, painted_wall_t],
        [c + painted_wall_t/sqrt(2), painted_wall_t],
        [painted_wall_t, c+ painted_wall_t/sqrt(2)]];
  
    if (transparent_concrete == false)
    {
        ani_win = (animation_mode==2 || animation_mode==3);
        w1a_open = ani_win ? (sin(2*360*$t) * 90 + 90) : 15;
        w1b_open = ani_win ? (sin(3*360*$t-90) * 90 + 90) : 35;
        w2_open = ani_win ? (sin(360*$t-90) * 90 + 90) : 45;
        w3_open = ani_win ? (sin(4*360*$t-90) * 90 + 90) : 180;
        w4_open = ani_win ? (sin(2*360*$t-90) * 90 + 90) : 180;
      
        translate([house_sz[0], 
            house_sz[1] - window_1a_move, 0])
        rotate([0,0,90])
        std_king_window(wall_t, w1a_open);

        translate([house_sz[0], 
            house_sz[1] - window_1b_move, 0])
        rotate([0,0,90])
        std_king_window(wall_t,w1b_open);
        
        translate([house_sz[0] - window_2_move, 
            house_sz[1], 0])
        rotate([0,0,180])
        std_king_window(wall_t,w2_open);
        
        translate([house_sz[0] - toilet_cut_d[0], 
            window_3_move, 0])
        rotate([0,0,90])
        small_king_window(wall_t, w3_open);
     
        translate([house_sz[0] - toilet_cut_d[0] 
                - window_4_move, 0, 0])
        small_king_window(wall_t, w4_open);
    }

// ************ REGULAR WINDOWS IN KITCHEN
    if (use_arc_windows == false && transparent_concrete == false) {
        translate([0, 
            house_sz[1] - window_5_move, 0])
        rotate([0,0,-90])
        std_king_window(wall_t, 180);

        /* translate([0, 
            house_sz[1] - window_6_move, 0])
        rotate([0,0,-90])
        wide_window(wall_t, 20); */

        translate([window_7_move, 0, 0])
        std_king_window(wall_t, 45);
        
        front_door_move = front_cut_diag / sqrt(2);
        translate([front_door_move, front_door_move, 0])
        rotate([0,0,-45])
        basicdoor(wall_t, false, 0, front_door_w); 
    }
        
    if (transparent_concrete == false)
    {
        ani_door = (animation_mode==1 || animation_mode==3);
        d1_open = ani_door ? (sin(2*360*$t) * 47 + 47) : 90;
        d2_open = ani_door ? (sin(2*360*$t) * 47 + 47) : 80;

        translate([house_sz[0]-bedroom_l-0.50*wall_t,
            bedroom_door_move, 0])
        rotate([0,0,90])
        basicdoor(wall_t, true, d1_open,75.4); 

        translate([house_sz[0]-bedroom_l-0.50*wall_t,
            bathroom_door_move, 0])
        rotate([0,0,90])
        basicdoor(wall_t, false, d2_open, 65.3); 
    }
    
    toilet_inside_w = bedroom_l - toilet_cut_d[0] - 0.5 * wall_t;
    toilet_inside_d = toilet_cut_d[1] - wall_t;
        
    color(paint_the_rooms)
        translate([sz[0]-(bedroom_l+wall_t)/2 
            - (bedroom_l - toilet_cut_d[0])/2, toilet_cut_d[1]+painted_wall_t/2,wall_height/2])
        cube([toilet_inside_w, wall_t, wall_height], center=true);
        
    d1 = sz[0] - toilet_cut_d[0] - wall_t;
    hdim(d1 - toilet_inside_w, d1, (toilet_cut_d[1]+wall_t)/2);

    translate([d1-toilet_inside_w/3,wall_t,0])
    rotate([0,0,90])
        hdim(0, toilet_inside_d, 0);
      
    difference() {
        color(paint_the_rooms)
        translate([sz[0]-wall_t-bedroom_l, sz[1]/2,wall_height/2])
        cube([wall_t, sz[1]-2*wall_t, wall_height], center=true);
    
        translate([house_sz[0]-bedroom_l-0.50*wall_t,
            bedroom_door_move, 0])
        rotate([0,0,90])
        basicdoorhole(wall_t); 
        
        translate([house_sz[0]-bedroom_l-0.50*wall_t,
            bathroom_door_move, 0])
        rotate([0,0,90])
        basicdoorhole(wall_t, 65.3); 
    }

    difference() {
        union() {
            color(wall_color)
            {
                if (true) {
                    linear_extrude(wall_height, convexity = 10)
                    difference() {
                        polygon(exteriorpoints);
                        polygon(interiorpoints);
                    } 
                } else {    
                    translate([house_sz[0]/2, 
                        house_sz[1]-wall_t/2, wall_height/2])
                    cube([house_sz[0]-2*wall_t, wall_t,
                        wall_height], center=true);
                    
                    tmp1 = house_sz[1]-toilet_cut_d[1];
                    translate([house_sz[0]-wall_t/2, 
                        toilet_cut_d[1] + tmp1/2, wall_height/2])
                    cube([wall_t, tmp1,
                        wall_height], center=true);

                    translate([(house_sz[0]-toilet_cut_d[0]) 
                        + toilet_cut_d[0]/2-wall_t/2, 
                        toilet_cut_d[1]+wall_t/2, wall_height/2])
                    cube([toilet_cut_d[0]-wall_t, wall_t,
                        wall_height], center=true);

                    translate([house_sz[0]-toilet_cut_d[0]-wall_t/2, 
                        toilet_cut_d[1]/2+wall_t/2, wall_height/2])
                    cube([wall_t, toilet_cut_d[1]+wall_t,
                        wall_height], center=true);
                        
                    tmp3 = front_cut_diag * sqrt(2);
                    tmp2 = house_sz[0] - toilet_cut_d[0] 
                        - wall_t - tmp3;
                    translate([tmp3 + tmp2/2, 
                        wall_t/2, wall_height/2])
                    cube([tmp2, wall_t,
                        wall_height], center=true);
                        
                    tmp4 = house_sz[1]-tmp3;
                    translate([wall_t/2, tmp3 + tmp4/2, 
                        wall_height/2])
                    cube([wall_t, tmp4,
                        wall_height], center=true);

                    tmp5 = (front_cut_diag + wall_t/2) / sqrt(2);
                    tmp6 = 2 * front_cut_diag;
                    translate([tmp5, tmp5, 
                        wall_height/2])
                        rotate([0,0,45])
                    cube([wall_t, tmp6,
                        wall_height], center=true);
                }
            }

            if (transparent_concrete == false)
            {
                color(paint_the_rooms)
                linear_extrude(wall_height, convexity = 10)
                difference() {
                    polygon(interiorpoints);
                    polygon(paintpoints);
                }
            }
        }
        
        translate([house_sz[0], 
            house_sz[1] - window_1a_move, 0])
        rotate([0,0,90])
        std_king_window_hole(wall_t);

        translate([house_sz[0], 
            house_sz[1] - window_1b_move, 0])
        rotate([0,0,90])
        std_king_window_hole(wall_t);
        
        translate([house_sz[0] - window_2_move, 
            house_sz[1], 0])
        rotate([0,0,180])
        std_king_window_hole(wall_t);
        
        translate([house_sz[0] - toilet_cut_d[0], 
            window_3_move, 0])
        rotate([0,0,90])
        small_king_window_hole(wall_t);
        
        translate([house_sz[0] - toilet_cut_d[0] 
            - window_4_move, 0, 0])
        small_king_window_hole(wall_t);
        
        // ************ ARC WINDOWS IN KITCHEN
        if (use_arc_windows) {
            translate([arc_window_1_move, 0, 0])
            arc_window_hole(wall_t);

            if (one_big_arc_window==false)
            {
                translate([0, arc_window_2_move, 0])
                rotate([0,0,-90])
                arc_window_hole(wall_t);

                translate([0, arc_window_3_move, 0])
                rotate([0,0,-90])
                arc_window_hole(wall_t);
            }
            else {
                arc_window_23_move = 240;
                translate([0, arc_window_23_move, 0])
                rotate([0,0,-90])
                arc_window_hole(wall_t, 250);
            }
            arc_door_h = 220;
            arc_door_move = front_cut_diag / sqrt(2);
            translate([arc_door_move, arc_door_move, 0])
            rotate([0,0,-45])
            arc_window_hole(wall_t+44, 
                arc_front_door_w, arc_door_h, 0);
        }

        // ************ REGULAR WINDOWS IN KITCHEN
        else {
            translate([0, 
                house_sz[1] - window_5_move, 0])
            rotate([0,0,-90])
            std_king_window_hole(wall_t);

            /* translate([0, 
                house_sz[1] - window_6_move, 0])
            rotate([0,0,-90])
            wide_window_hole(wall_t); */

            translate([window_7_move, 0, 0])
            std_king_window_hole(wall_t);
            
            front_door_move = front_cut_diag / sqrt(2);
            translate([front_door_move, front_door_move, 0])
            rotate([0,0,-45])
            basicdoorhole(wall_t+20, front_door_w); 
        }
    }
    
    color(wall_color2)
    translate([0,0, wall_height])
    wall_extension(house_sz, front_cut_diag, toilet_cut_d, wall_t);
 }
 
 module wall_extension(house_sz, front_cut_diag, toilet_cut_d, wall_t, ext_height=100, roof_angle=20, extra_height=11)
 {
     difference()
     {
         union (){
            tmp1 = house_sz[1]-toilet_cut_d[1];
            translate([house_sz[0]-wall_t/2, 
                toilet_cut_d[1] + tmp1/2, ext_height/2])
            cube([wall_t, tmp1,
                ext_height], center=true);

            translate([(house_sz[0]-toilet_cut_d[0]) 
                + toilet_cut_d[0]/2-wall_t/2, 
                toilet_cut_d[1]+wall_t/2, ext_height/2])
            cube([toilet_cut_d[0]-wall_t, wall_t,
                ext_height], center=true);

            translate([house_sz[0]-toilet_cut_d[0]-wall_t/2, 
                toilet_cut_d[1]/2+wall_t/2, ext_height/2])
            cube([wall_t, toilet_cut_d[1]+wall_t,
                ext_height], center=true);
                
            tmp3 = front_cut_diag * sqrt(2);
            tmp2 = house_sz[0] - toilet_cut_d[0] 
                - wall_t - tmp3;
                
            tmp4 = house_sz[1]-tmp3;
            translate([wall_t/2, tmp3 + tmp4/2, 
                ext_height/2])
            cube([wall_t, tmp4,
                ext_height], center=true);

            tmp5 = (front_cut_diag + wall_t/2) / sqrt(2);
            tmp6 = 2 * front_cut_diag;
            translate([tmp5, tmp5, 
                ext_height/2])
                rotate([0,0,45])
            cube([wall_t, tmp6,
                ext_height], center=true);
        }
            
        diag = house_sz[1]/2 / cos(roof_angle) + 10;
        
        translate([0, 0, extra_height]) 
        rotate([roof_angle, 0, 0])
        translate([house_sz[0]/2, diag/2, ext_height/2]) 
        cube([house_sz[0]+1, diag, 
            ext_height/cos(roof_angle)], center=true);
        
        translate([0, house_sz[1], extra_height]) 
        rotate([-roof_angle, 0, 0])
        translate([house_sz[0]/2, -diag/2, ext_height/2]) 
        cube([house_sz[0]+1, diag,
            ext_height/cos(roof_angle)], center=true);
    }
}


// For testing
walls(house_sz = [495, 410], front_cut_diag = 60, toilet_cut_d = [115, 145],wall_t=15, wall_height=260, transparent_concrete=false);