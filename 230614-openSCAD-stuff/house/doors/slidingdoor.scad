
module slidingdoor(width=240, height=210, wall_thickness=15) 
{
    door_thickness = 4.0;
    profile_width = 4;
    profile_depth = 3.0;
    frame_profile_width = 4;
    frame_profile_depth = wall_thickness;
    
    translate([0, 
        -(frame_profile_depth-door_thickness)/2, height/2])
    union() {
             
        /* Outer frame fixed to concrete wall. */
        color([0.2,0.0,0.1])
        genericdoorframe(width, height, frame_profile_width, frame_profile_depth);
    
        /* Calculate opning size. */
        open_w = width - 2 * frame_profile_width;
        open_h = height - 2 * frame_profile_width;
        half_open_w = (open_w + frame_profile_width)/2; 
        
        /* Left window glass frame. */
        translate([-(open_w)/4, profile_depth/2, 0]) 
        color([0.5,0.3,0.3])
        genericdoorframe(half_open_w, open_h, profile_width, profile_depth);
    
        /* Right window glass frame. */
        translate([(open_w)/4, -profile_depth/2, 0]) 
        color([0.5,0.3,0.3])
        genericdoorframe(half_open_w, open_h, profile_width, profile_depth);
    }
}

module genericdoorframe(width=70, height=110, profile_width = 5, profile_depth = 8) 
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

/* For testing */
slidingdoor();