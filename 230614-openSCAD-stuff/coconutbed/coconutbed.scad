use <bedside.scad> 
use <bedend.scad> 
use <bedsupport.scad> 
use <playwood.scad> 


explode = true;
show_playwood = true;

matress_length = 75 * 2.54;
matress_width = 60 * 2.54;
cw_w = 5.08;
cw_h = 15.24;
jw_w = 4.8;
jw_h = 4.8;
groove_depth = 1.5;


module coconutbed() 
{
    translate([0, matress_width/2 + (explode ? 45 : 0), 0]) 
        bedside(matress_length, cw_w, cw_h, jw_w, jw_h, groove_depth); 
  
    translate([0,-matress_width/2 - (explode ? 45 : 0), 0]) 
        rotate([0,0,180]) 
        bedside(matress_length, cw_w, cw_h, jw_w, jw_h, groove_depth); 

    translate([matress_length/2,0, 0]) 
        bedend(matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth); 

    translate([-matress_length/2,0, 0]) 
        rotate([0,0,180]) 
        bedend(matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth); 

    translate([0, 0, explode ? 60 : 0]) 
        bedsupport(matress_length,matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth); 
    
    translate([matress_length/4, 0, explode ? 60 : 0]) 
        bedsupport(matress_length,matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth);
 
    translate([-matress_length/4, 0, explode ? 60 : 0]) 
        bedsupport(matress_length,matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth);

    if (show_playwood)
    {
        translate([-matress_length/4, 0, explode ? 160 : 0]) 
            playwood(matress_length, matress_width); 
        
        translate([matress_length/4, 0, explode ? 140 : 0]) 
            rotate([0,0,180])
            playwood(matress_length, matress_width); 
    }
}

coconutbed();