use <dividerwall.scad> 

module workroom()
{
    room_length = 420;
    room_width = 440;
    computer_room_length = 320; 
    computer_room_width = 280;
    shelf_w = computer_room_length;
    shelf_h = 210;
    wood_w = 15;    // Coconut wood width
    wood_t = 4.5;     // Coconut wood thickness
    explode = false;
    
    // Floor
    floor_thickness = 5;
    translate([0,0,-floor_thickness])
    color([0.9,0.9,0.75, 1.0])
    cube([room_length, room_width, floor_thickness]);
    
    // Divider wall
    translate([shelf_w/2,computer_room_width,0])
    dividerwall(shelf_w, shelf_h, wood_w, wood_t, explode);
}        

workroom();