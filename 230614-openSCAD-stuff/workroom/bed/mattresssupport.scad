use <smallscrew.scad> 
use <../hdim.scad> 
wood_thickness = 0.9 * 2.54;
wood_width = 1.9 * 2.54;
wood_spacing = 1.95 * 2.54;
spacing = 0.3;
screw_align = 2.0 * 2.54;

module mattresssupport(mattress_length=190, mattress_width = 152.4) 
{
    screw_pos_1 = mattress_length/4+screw_align;
    screw_pos_2 = mattress_length/4-screw_align;
    screw_pos_3 = -mattress_length/4+screw_align;
    screw_pos_4 = -mattress_length/4-screw_align;

    translate([0,0,wood_thickness])
        for (y=[0:wood_width+wood_spacing:mattress_width/2-wood_spacing]) 
        {
            translate([0,mattress_width/2 - wood_width/2 - y,0])
            color([0.80,0.43,0.32])
            cube([mattress_length-2*spacing, wood_width, wood_thickness],center=true);

            translate([screw_pos_1,
                mattress_width/2 - wood_width/2 - y,
                wood_thickness/2+0.1])
            smallscrew();

            translate([screw_pos_2,
                mattress_width/2 - wood_width/2 - y,
                wood_thickness/2+0.1])
            smallscrew();

            translate([screw_pos_3,
                mattress_width/2 - wood_width/2 - y,
                wood_thickness/2+0.1])
            smallscrew();

            translate([screw_pos_4,
                mattress_width/2 - wood_width/2 - y,
                wood_thickness/2+0.1])
            smallscrew();
            
            translate([0,-mattress_width/2 + wood_width/2 + y,0])
            color([0.80,0.43,0.32])
            cube([mattress_length-2*spacing, 
                wood_width, wood_thickness],center=true);
            
            translate([screw_pos_1,
                -mattress_width/2 + wood_width/2 + y,
                wood_thickness/2+0.1])
            smallscrew();

            translate([screw_pos_2,
                -mattress_width/2 + wood_width/2 + y,
                wood_thickness/2+0.1])
            smallscrew();

            translate([screw_pos_3,
                -mattress_width/2 + wood_width/2 + y,
                wood_thickness/2+0.1])
            smallscrew();

            translate([screw_pos_4,
                -mattress_width/2 + wood_width/2 + y,
                wood_thickness/2+0.1])
            smallscrew();
        }
        
   translate([0, -mattress_width/2, wood_thickness]) 
   rotate([0,0,0]) 
   hdim(-mattress_length/2+spacing, mattress_length/2-spacing, 0, 13);
}

mattresssupport();