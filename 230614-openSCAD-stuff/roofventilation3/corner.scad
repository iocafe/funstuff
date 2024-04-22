use <vertical2x2.scad>
use <playwood.scad>
use <hdim.scad> 
use <vdim.scad> 


module corner(corner_diam = 40, corner_height = 100, cut_depth=3, playwood_thickness= 1.5, roof_angle=20, explode=true) 
{
    wood_2x2_width = 4; 
    roof_angle = -roof_angle;
    delta = playwood_thickness + wood_2x2_width/2;
    cut_depth2=cut_depth-playwood_thickness;
    
    x1 = delta;
    y1 = delta;
    x2 = corner_diam - delta;
    y2 = corner_diam - delta;
    h1 = corner_height - (y1-wood_2x2_width/2) * tan(roof_angle);
    h2 = corner_height - (y2-wood_2x2_width/2) * tan(roof_angle);
    h3 = h2; // 2 * h2 - h1;
    
    expd = explode ? 20 : 0;
    
    
    translate([x1 - expd, delta/2 - expd, 0]) {
        vertical2x2(h1, wood_2x2_width, 0,cut_depth2, cut_depth2);
        if (explode) vdim(-h1, 0, 0, 5);
    }
    
    translate([x2 + expd, delta/2 - expd, 0]) {
        vertical2x2(h2, wood_2x2_width, 0);
        if (explode) vdim(-h2, 0, 0, 5);
    }
    
    translate([x1 - expd, y2-delta/2 + expd, 0])
    {
        vertical2x2(h2, wood_2x2_width, 0);
        if (explode) vdim(-h2, 0, 0, 5);
    }
    
    translate([x2 + expd, y2-delta/2 + expd, 0])
    {
        vertical2x2(h3, wood_2x2_width, 0);
        if (explode) vdim(-h3, 0, 0, 5);
    }
    
    translate([-expd,playwood_thickness+cut_depth2,0]) {
        dx = corner_diam-2*playwood_thickness-cut_depth2;
        playwood(dx, corner_height-(playwood_thickness+cut_depth2)*tan(roof_angle), playwood_thickness, roof_angle); 
        rotate([0, 0, 90]) hdim(0, dx, 10, 10);
    }

    translate([corner_diam-playwood_thickness + expd,0,0])
    playwood(corner_diam-playwood_thickness, corner_height-(corner_diam-playwood_thickness)*tan(roof_angle), playwood_thickness, 0 /* roof_angle */); 
 
    translate([cut_depth,playwood_thickness - expd,0])
    rotate([0,0,270])
    playwood(corner_diam-cut_depth-playwood_thickness, corner_height, playwood_thickness, roof_angle); 
    
    translate([0,corner_diam + expd,0])
    rotate([0,0,270])
    playwood(corner_diam, corner_height - (corner_diam)*tan(roof_angle),  playwood_thickness, 0 /* roof_angle */); 
}


corner();