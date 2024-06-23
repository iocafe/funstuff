module fridge(width = 54, depth = 57, height = 148, door_angle = 45)
{
    door_thickness = 6;
    door_gap = 1;
    body_depth = depth-door_thickness-door_gap;
    
    translate([0, 0, 0]) 
    color([0.8,0.8,0.8, 1.0])
    cube([depth-door_thickness-door_gap, width, height], center = false);

    translate([depth-door_thickness, width, 0]) 
    rotate([0,0,door_angle])
    translate([0, -width, 0]) 
    color([0.75,0.75,0.75, 1.0])
    cube([door_thickness, width, height], center = false);
}        

fridge();