use <bedside.scad> 
use <bedend.scad> 
use <bedsupport.scad> 
use <playwood.scad> 
use <mattresssupport.scad> 


explode = true;
show_playwood = false;
show_wood_support = false;
large_bed = false;

/* small bed ~ 75" x 54", large bed ~ 75" 50"  */
matress_length = large_bed ? 191.3 : 190.2;  
matress_width = large_bed ? 152.5 : 137.8;

cw_w = large_bed ? 4.1 : 4.5;
cw_h = large_bed ? 6.8*2.54 : 6.2 * 2.54;
jw_w = 4.7;
jw_h = 4.7;
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
        bedsupport(matress_length,matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth, true); 
    
    translate([matress_length/4, 0, explode ? 60 : 0]) 
        bedsupport(matress_length,matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth, false);
 
    translate([-matress_length/4, 0, explode ? 60 : 0]) 
        bedsupport(matress_length,matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth, false);

    if (show_playwood)
    {
        translate([-matress_length/4, 0, explode ? 160 : 0]) 
            playwood(matress_length, matress_width); 
        
        translate([matress_length/4, 0, explode ? 140 : 0]) 
            rotate([0,0,180])
            playwood(matress_length, matress_width); 
    }
    
    if (show_wood_support) 
    {
        translate([0, 0, explode ? 160 : 0]) 
            mattresssupport(matress_length, matress_width); 
    }
}

coconutbed();