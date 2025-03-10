use <dividerwall.scad> 
use <frontwall.scad> 
use <fridge.scad> 
use <laundrytable.scad>
use <basicdoor.scad> 
use <slidingwindow.scad>
use <computertable2/computertable.scad>
use <worktable/worktable.scad>
use <printershelf/printershelf.scad>

module workroom()
{
    explode = false;
    show_furniture = true;
    show_floor = false;
    
    // Inside size of the room
    room_length = 420;
    room_width = 440;
    
    // Computer room size as measure OUTSIDE awllf wall of the room to inside concrete wall
    computer_room_length = 325; 
    computer_room_width = 262;
    
    fridge_width = 54;
    fridge_depth = 57;
    fridge_height = 148;
    fridge_door_angle = 45;
    fridge_back_gap = 7;
    fridge_side_gap = 2;
    
    pipe_diam = 2.54;
    wood_w = 17;      // Coconut wood width
    wood_t = 4.5;     // Coconut wood thickness
    gim_t = 4.3;      // Gimelina wood thickness
    shelf_depth = 2 * wood_w + 0.3;
    
    // Floor
    if (!explode && show_floor) {
        floor_thickness = 5;
        translate([0,0,-floor_thickness])
        color([0.9,0.9,0.75, 1.0])
        cube([room_length, room_width, floor_thickness]);
    }
    
    // Divider wall
    translate([0,computer_room_width-shelf_depth/2,0])

    dividerwall(computer_room_length, wood_w, wood_t, gim_t, pipe_diam, fridge_depth+fridge_back_gap,explode);

    // Front wall
    translate([computer_room_length-shelf_depth/2,computer_room_width,gim_t])
    rotate([0,0,270])
    frontwall(computer_room_width, wood_w, wood_t, gim_t, pipe_diam, fridge_width+fridge_side_gap,explode);
    
    if (!explode)
    {
        // Fridge
        translate([computer_room_length - fridge_depth, computer_room_width - fridge_width, 0])
        fridge(fridge_width, fridge_depth, fridge_height, fridge_door_angle);
       
        // Layndry table
        laundrytable_width = 330;
        laundrytable_depth = 65.5;
        laundrytable_height = 79;
        translate([0,room_width,0])
        rotate([0,0,-90])
        laundrytable(laundrytable_width, laundrytable_depth, laundrytable_height);
        
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
            
        if (show_furniture) {
            work_table_depth = 56;
            table_height = 77.8;
            
            // Computer table
            translate([computer_room_length - shelf_depth - 20, 0, 0])
            rotate([0,2,90])
            computertable(computer_room_length - shelf_depth - work_table_depth - 40/*width */, 60.0 /* depth */, table_height);

            // Work table
            translate([2, 2+10, 0])
            rotate([0,0,0])
            worktable(computer_room_width - shelf_depth - 98.7/*width */, work_table_depth /* depth */, table_height);

            // Printer shelf
            translate([work_table_depth + 62, computer_room_width - shelf_depth - 2, 0])
            rotate([0,0,270])
            printershelf(computer_room_width - shelf_depth - 100/*width */, 34.0 /* depth */, 77 /* height */, explode);
        }
    
        translate([-0.05,-0.05,-0.05])
        color([0,0,0.9,0.2])
        cube([computer_room_length+0.1,computer_room_width+0.1,215.1]);
        

    }
}        

workroom();