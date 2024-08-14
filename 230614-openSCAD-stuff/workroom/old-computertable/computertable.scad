use <../anglebarframe.scad>
use <../simpleplaywood.scad>
use <../hdim.scad>
use <legpair.scad>

leg_dist_from_end = 8;
leg_dist = 53;
wheel_assy_h = 7.3;
plywood_t = 0.75 * 2.54;

module computertable(width = 194.7, depth = 60, height = 77.8, explode=false)
{
    above_wheel_assy = height - wheel_assy_h;
    translate([0,0,wheel_assy_h])
    {
        translate([0,0,above_wheel_assy])
        computertable_top(width, depth, explode);
        
        leg_offs = 1;
        translate([depth/2-leg_offs,width-leg_dist_from_end,0])
        leg_pair(above_wheel_assy-plywood_t,0, leg_dist, 2.54, true, explode);
        
        translate([depth/2-leg_offs,leg_dist_from_end,0])
        leg_pair(above_wheel_assy-plywood_t,0, leg_dist, 2.54, false, explode);
        
        text_size = 4;
        row_step = 7;
        xmargin = 5;
        ystart = width - row_step;
        color([0.8,0.8,0.8, 0.2]) 
        cube([depth, width, above_wheel_assy], center = false);
        
        color([0.9,0.9,0.1,1.0])
        {
            t1 = "COMPUTER TABLE"; 
            t2 = str(width, "cm x ", depth, "cm");
            translate([depth-xmargin,ystart,above_wheel_assy]) { 
                text(t1, size = text_size, 
                    halign = "right",valign = "top");
                translate([0, -8, 0]) 
                text(t2, size = text_size, 
                    halign = "right",valign = "top");
            }
     
        } 
    }
}        

module computertable_top(width = 194.7, depth = 60, explode=false)
{
    anglebar_thickness = 0.3;
    playwood_allowance = 0.3 + anglebar_thickness; // Needs to include 0.3 mm for angle bar
 
    anglebarframe(depth, width, explode);
    
    hole_delta = 15;
    hole_w = 30;
    hole_move = 27;
    hole_depth = 8;
    hole_pos = 9;
    rounded_end_d = 4.5;
    small_hole_w = 28;
    small_hole_move = 71;
    small_hole_pos = 9;
    small_hole_depth = 8;
    
    difference()
    {
        translate([0, 0, 0-anglebar_thickness])
        simpleplaywood(depth, width, playwood_allowance);

    
        translate([hole_pos, width/2+hole_move, -2])
        minkowski()
        {
            cube([hole_depth-rounded_end_d, hole_w-rounded_end_d, 0.001], center = true);
            cylinder(d=rounded_end_d,h=5, center=true, $fn = 22);
        }
        
        translate([hole_pos, width/2-hole_move, -2])
        minkowski()
        {
            cube([hole_depth-rounded_end_d, hole_w-rounded_end_d, 0.001], center = true);
            cylinder(d=rounded_end_d,h=5, center=true, $fn = 22);
        }
        
        translate([small_hole_pos, width/2+small_hole_move, -2])
        minkowski()
        {
            cube([small_hole_depth-rounded_end_d, small_hole_w-rounded_end_d, 0.001], center = true);
            cylinder(d=rounded_end_d,h=5, center=true, $fn = 22);
        }
        
        translate([small_hole_pos, width/2-small_hole_move, -2])
        minkowski()
        {
            cube([small_hole_depth-rounded_end_d, small_hole_w-rounded_end_d, 0.001], center = true);
            cylinder(d=rounded_end_d,h=5, center=true, $fn = 22);
        } 
    }
    
    hdim(0, hole_pos+hole_depth/2, 12, 20);
    hdim(0, hole_pos-hole_depth/2, 12, 16);
    
    p1 = width/2-hole_move+hole_w/2;
    translate([0,p1,0]) rotate([0,0,-90])
    hdim(0, p1, 5, 22);
    
    p2 = width/2-hole_move-hole_w/2;
    translate([0,p2,0]) rotate([0,0,-90])
    hdim(0, p2, 5, 17);
    
    p3 = width/2-small_hole_move+small_hole_w/2;
    translate([0,p3,0]) rotate([0,0,-90])
    hdim(0, p3, 5, 12);
 
    p4 = width/2-small_hole_move-small_hole_w/2;
    translate([0,p4,0]) rotate([0,0,-90])
    hdim(0, p4, 5, 7);
   
    translate([hole_pos, width/2,0])
    cable_support(width-100, hole_depth+3, depth = 10);
}

module cable_support(length = 80, width=14, depth = 10)
{
    plywood_t = 0.75*2.54;
    color([0.8,0.9,0.8,1])
    translate([0,0,-depth-3*plywood_t/2])
    cube([width+2*plywood_t, length, plywood_t], center = true);   
    translate([width/2+plywood_t/2,0,-depth/2-plywood_t])
    cube([plywood_t, length, depth], center = true);   
    translate([-width/2-plywood_t/2,0,-depth/2-plywood_t])
    cube([plywood_t, length, depth], center = true);   
    
    translate([-width/2-plywood_t,0,-depth-2.5*plywood_t])
    hdim(0, width+2*plywood_t, 0, 8);

    translate([width/2+plywood_t,0,-plywood_t])
     rotate([0,90,0])
    hdim(0, depth, 0, 8);
    
    translate([width/2+plywood_t,-length/2,-depth-2.5*-plywood_t])
     rotate([0,0,90])
    hdim(0, length, 0, 8);
}

// cable_support();

computertable(explode=false);