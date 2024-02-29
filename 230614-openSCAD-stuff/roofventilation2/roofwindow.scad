use <generic/genericframe.scad>

module roofwindow(width=80, height=60, wall_thickness=10) 
{
    profile_width = 1.8;
    profile_depth = 1.5;
    frame_profile_width = 4;
    frame_profile_depth = wall_thickness;
    
    /* Outer frame fixed to concrete wall. */
    color([0.2,0.0,0.1])
    genericframe(width, height, frame_profile_width, frame_profile_depth);

    /* Calculate opening size. */
    open_w = width - 2 * frame_profile_width;
    open_h = height - 2 * frame_profile_width;
    half_open_w = (open_w + frame_profile_width)/2; 
    
    /* Left window glass frame. */
    translate([-(open_w)/4, 0, 0]) 
    color([0.5,0.3,0.3])
    windowframe(half_open_w, open_h, profile_width, profile_depth);

    /* Right window glass frame. */
    translate([(open_w)/4, 0, 0]) 
    color([0.5,0.3,0.3])
    windowframe(half_open_w, open_h, profile_width, profile_depth);
}

module windowframe(width=70, height=110, profile_width = 5, profile_depth = 8) 
{
    translate([-(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);
    
    translate([(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);

    translate([0, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);

    translate([0, 0, -(height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);

    translate([0, 0, (height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);

    translate([0, 0, 0]) 
    cube([width, profile_depth, profile_width], center=true);
    translate([0, 0, -(height - profile_width)/4]) 
    cube([width, profile_depth, profile_width], center=true);
    translate([0, 0, (height - profile_width)/4]) 
    cube([width, profile_depth, profile_width], center=true);
}    

module genericframe(width=70, height=110, profile_width = 5, profile_depth = 8) 
{
    translate([-(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);
    
    translate([(width - profile_width)/2, 0, 0]) 
    cube([profile_width,profile_depth, height], center=true);

    
    translate([0, 0, -(height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);

    translate([0, 0, (height - profile_width)/2]) 
    cube([width, profile_depth, profile_width], center=true);
}    
// For testing
roofwindow();