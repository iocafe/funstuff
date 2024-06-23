use <dividerwall.scad> 
use <fridge.scad> 
use <basicdoor.scad> 
use <slidingwindow.scad>

module workroom()
{
    // Inside size of the room
    room_length = 420;
    room_width = 440;

    // Computer room size as measure OUTSIDE awllf wall of the room to inside concrete wall
    computer_room_length = 330; 
    computer_room_width = 265;
    
    fridge_width = 54;
    fridge_depth = 57;
    fridge_height = 148;
    fridge_door_angle = 45;
    fridge_back_gap = 5;
    fridge_side_gap = 1;
    
    pipe_diam = 2.54;
    shelf_w = computer_room_length - fridge_depth;
    shelf_h = 210;
    wood_w = 15;    // Coconut wood width
    wood_t = 4.5;     // Coconut wood thickness
    explode = false;
    shelf_depth = 2 * wood_w + 0.2;
    
    // Floor
    floor_thickness = 5;
    translate([0,0,-floor_thickness])
    color([0.9,0.9,0.75, 1.0])
    cube([room_length, room_width, floor_thickness]);
    
    // Divider wall
    translate([shelf_w/2,computer_room_width-shelf_depth/2,0])
    dividerwall(shelf_w, shelf_h, wood_w, wood_t, pipe_diam, explode);
    
    // Fridge
    translate([computer_room_length - fridge_depth, computer_room_width - fridge_width - fridge_side_gap, 0])
    fridge(fridge_width, fridge_depth, fridge_height, fridge_door_angle);
    
    // Door between kitchen and work room
    translate([room_length+7.5,119,0])
    rotate([0,0,90])
    basicdoor(80); 
    
    // Door out of the house
    translate([room_length-9-80/2,-7.5,0])
    rotate([0,0,180])
    basicdoor(80, 213.2, 15, true); 
    
    // Computer room windows
    translate([163,-7.5,152])
    slidingwindow(174+8,112+8);
    translate([-7.5,147, 152])
    rotate([0,0,90])
    slidingwindow(77,139);
}        

workroom();