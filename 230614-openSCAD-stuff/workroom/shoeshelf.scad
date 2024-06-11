// use <bolt.scad> 

module workroom()
{
    room_length = 420;
    room_width = 440;
    
    // Floor
    floor_thickness = 5;
    translate([0,0,-floor_thickness])
    color([0.9,0.9,0.75, 1.0])
    cube([room_length, room_width, floor_thickness]);
}        

workroom();