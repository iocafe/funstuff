use <hdim.scad> 

module shelf(shelf_w = 90, wood_w = 15, wood_t = 5, gap = 0.3, pipe_dx=8, pipe_dy=3, pipe_diam = 2.54,is_bottom_shelf=true, explode=true)
{
    wood_y = wood_w/2+gap/2 + (explode ? 10 : 0);
    translate([0, wood_y, wood_t/2])
        onewood(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, false, explode);

    translate([0, -wood_y, wood_t/2])
        onewood(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, true, explode);

    brace_z = explode ? -7 : 0;
    if (!is_bottom_shelf)
    {
        translate([shelf_w/4+2, 0, brace_z]) 
        ironbrace(2*wood_w+gap);
        
        translate([-shelf_w/4-2, 0, brace_z]) 
        ironbrace(2*wood_w+gap);
    }
    
    if (is_bottom_shelf)
    {
        brace_w = 4;
        brace_t = 0.3;
        screw_hole_diam = 0.6;
        translate([shelf_w/2-pipe_dx, wood_w+gap/2-3.5/2*brace_w-0.5, -brace_t/2+brace_z]) difference()
        {
            color([0.23,0.12,0.10, 1.0])
            cube([brace_w, 3.5*brace_w, brace_t], center=true);
        
            translate([0.3*brace_w,1.6*brace_w, 0])
            cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
            translate([0,0.6*brace_w, 0])
            cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
            translate([0,-brace_w, 0])
            cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
        }
        
        if (explode) 
        {
            hdim(shelf_w/4, shelf_w/2, -wood_y, 4.0+wood_w/2);
            hdim(-shelf_w/2, shelf_w/2, wood_y+wood_w/2, -9.0); 
            hdim(shelf_w/4-4, shelf_w/2, -wood_y-wood_w/2, 9.0); 
            hdim(-shelf_w/2, -shelf_w/2+pipe_dx, -wood_y-wood_w/2, 6.0); 

            translate([shelf_w/2-pipe_dx, wood_y+wood_w/2-pipe_dy/2, wood_t/2])
            rotate([0,0,90]) hdim(-pipe_dy/2, pipe_dy/2, 0, pipe_dx+6.0); 
        }
    }
}        

module onewood(shelf_w, wood_w, wood_t, gap, pipe_dx, pipe_dy, pipe_diam, is_front, explode)
{
    hole_y = is_front ? -wood_w/2+pipe_dy : wood_w/2-pipe_dy;
    right_hole_x = shelf_w/2-pipe_dx;
    difference()
    {
        color([0.75,0.48,0.19, 1.0])
        translate([0,0,0])
        cube([shelf_w, wood_w, wood_t], center=true);
        
        translate([right_hole_x, hole_y,0])
        cylinder(h=wood_t+0.5,r=pipe_diam/2,center = true, $fn = 16);

        translate([-shelf_w/2+pipe_dx, hole_y,0])
        cylinder(h=wood_t+0.5,r=pipe_diam/2,center = true, $fn = 16);
    }
}   

module ironbrace(shelf_depth)
{
    brace_w = 4;
    brace_t = 0.3;
    brace_d1 = 4;
    brace_d2 = 1;
    n_screw_holes = 4;
    brace_l = shelf_depth - brace_d1 - brace_d2;
    screw_range = brace_l - 3;
    screw_step = screw_range/(n_screw_holes-1);
    first_screw = -screw_range/2;
    screw_hole_diam = 0.6;

    translate([0,(brace_d1-brace_d2)/2,-brace_t/2]) difference()
    {
        color([0.23,0.12,0.10, 1.0])
        cube([brace_w, brace_l, brace_t], center=true);
        
        for (x = [0: n_screw_holes-1]) {
            translate([0,x * screw_step + first_screw, 0])
            cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
        }
    }
}

shelf();