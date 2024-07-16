use <anglebarframe.scad> 
use <rectbracket.scad> 

explode = false;
small_bar_diam = 2;
small_bar_t = 0.2;
large_bar_diam = 3.8;
large_bar_t = 0.3;
frame_length = 104;
frame_width = 82.6;

leg_length = 63;
bracket_length = 10;
bracket_width = 2;
bracket_t = 0.3;

c = [0.5,0.28,0.19, 1.0];

module patiotable()
{
    // d = explode ? 20 : 0;
    // c1 = [0.5,0.28,0.19, 1.0];
    // c2 = [0.8,0.30,0.29, 1.0];
    
    anglebarframe(frame_length, frame_width, large_bar_diam,
large_bar_t, explode);
    
    translate([-large_bar_t,-small_bar_t,large_bar_diam+large_bar_t])
    rotate([90,270,0])
    anglebar(leg_length, c, small_bar_diam, small_bar_t);
    
    translate([-large_bar_t,0,0])
    rotate([0,0,-90])
    rectbracket(bracket_length, bracket_width, bracket_t, false);

    translate([frame_length+large_bar_t,small_bar_t,large_bar_diam+large_bar_t])
    rotate([90,270,90])
    anglebar(leg_length, c, small_bar_diam, small_bar_t);
    
    translate([frame_length ,0,0])
    rotate([0,0,-90])
    rectbracket(bracket_length, bracket_width, bracket_t, true);

    translate([-large_bar_t,frame_width-small_bar_t,large_bar_diam+large_bar_t])
    rotate([90,270,-90])
    anglebar(leg_length, c, small_bar_diam, small_bar_t);
    
    translate([0,frame_width,0])
    rotate([0,0,90])
    rectbracket(bracket_length, bracket_width, bracket_t, false);
    
    translate([frame_length+large_bar_t,frame_width-small_bar_t,large_bar_diam+large_bar_t])
    rotate([90,270,180])
    anglebar(leg_length, c, small_bar_diam, small_bar_t);
    
    translate([frame_length,frame_width,0])
    rotate([0,0,90])
    rectbracket(bracket_length, bracket_width, bracket_t, false);
    
    translate([0,small_bar_t,0])
    anglesupport(small_bar_diam, small_bar_t, true);
    
    translate([frame_length,small_bar_t,0])
    rotate([0,0,90])
    anglesupport(small_bar_diam, small_bar_t);
    
    translate([0,frame_width - small_bar_t,0])
    rotate([0,0,-90])
    anglesupport(small_bar_diam, small_bar_t);

    translate([frame_length,frame_width - small_bar_t,0])
    rotate([0,0,180])
    anglesupport(small_bar_diam, small_bar_t);
}        



patiotable();