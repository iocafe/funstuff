
module basicdoor(width=95.3, height=213.2, wall_thickness=15, right_handed = true, open_angle = 0) 
{
    profile_width = 12;
    door_thickness = 4.0;
    frame_profile_width = 2.3;
    frame_profile_depth = wall_thickness;
    seal_profile_width = 1.0;
    
    /* Outer frame fixed to convrete wall. */
    color([0.3,0.0,0.1])
    basicdoorframe(false, width, height, frame_profile_width, frame_profile_depth);

    color([0.4,0.2,0.2])
    translate([0, door_thickness/2,-frame_profile_width/2])
    basicdoorframe(false, width - 2 * frame_profile_width,
        height - frame_profile_width, 
        seal_profile_width, frame_profile_depth - door_thickness);
    
    /* Calculate door size. */
    open_w = width - 2 * frame_profile_width - 0.6;
    open_h = height - frame_profile_width - 1.0;

    ow = open_w/2 + 0.2;
    translate([right_handed?-ow:ow, 
        -(frame_profile_depth-door_thickness)/2, -frame_profile_width/2])
    rotate([0, 0, right_handed?-open_angle:open_angle])
    translate([right_handed?ow:-ow, 0, 0])
     union() {
        /* Playwood */
        color([0.4,0.0,0.1])
        cube([open_w, 1.5, open_h], center=true);
        
        /* Door strengtehing. */
        color([0.5,0.2,0.2])
        basicdoorframe(true, open_w, open_h, profile_width, door_thickness);
        
         /* Diagonal strengthening */
        dx = open_w - 2*profile_width;
        dy = open_h - 2*profile_width;
        l = sqrt(dx*dx+dy*dy);
        rotate([0,-atan2(dx,dy), 0])
        color([0.5,0.2,0.2])
        cube([profile_width, door_thickness, l], center=true);
         
         /* Door knob */
         translate([open_w/2 - 6.0, 0, 0])
         color([218/255,172/255,96/255])
         doorknob(door_thickness);
    }
}

module basicdoorframe(draw_bottom=true,width=70, height=110, profile_width = 5, door_thickness = 8) 
{
    translate([-(width - profile_width)/2, 0, 0]) 
    cube([profile_width,door_thickness, height], center=true);
    
    translate([(width - profile_width)/2, 0, 0]) 
    cube([profile_width,door_thickness, height], center=true);

    if (draw_bottom) {
        translate([0, 0, -(height - profile_width)/2]) 
        cube([width, door_thickness, profile_width], center=true);
    }
    
    translate([0, 0, (height - profile_width)/2]) 
    cube([width, door_thickness, profile_width], center=true);
}    

module doorknob(door_thickness = 8)
{
    doorknob_length = 7;
    doorknob_r = 3.5;
    
    translate([0, doorknob_length, 0]) 
    sphere(r=doorknob_r);
    translate([0, -doorknob_length, 0]) 
    sphere(r=doorknob_r);
 
    rotate([90, 90, 0])
    cylinder(h = doorknob_length*2, r = 0.5 * doorknob_r, center=true);
   
    cube([8, door_thickness+0.2, 15],center=true); 
}

// For testing
basicdoor();