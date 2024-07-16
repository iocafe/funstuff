use <hdim.scad> 

module rectbracket(length = 10, width = 2, bracket_t = 0.3, show_dimensions=false)
{
    c = [0.9,0.8,0.59, 1.0];
   
    translate([-5, 0, 1])
    rotate([0, 30, 0]) {
        color(c)
        cube([width, bracket_t, length]);
        
        if (show_dimensions) {
            rotate([0,-90,0]) 
            hdim(0, length, 0, 9);
        }
    }
}   


rectbracket();