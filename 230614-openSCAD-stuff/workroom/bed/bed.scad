use <bedside.scad> 
use <bedend.scad> 
use <bedsupport.scad> 
use <playwood.scad> 
use <mattresssupport.scad> 
use <bedpipe.scad> 
use <../hdim.scad> 

show_playwood = false;
show_matress = false;
show_wood_support = false;

jw_w = 4.4;
jw_h = 4.4;
groove_depth = 1.2;


module coconutbed(matress_length = 190.3, matress_width = 94, wood_w = 17, wood_t = 4.5, pipe_diam = 2.54, gap_washer = 1.5, bed_height = 35.5, explode = false) 
{
    cw_w = wood_t;
    cw_h = wood_w;

    bed_delta_z = 3;
    translate([0,matress_width/2+wood_t/2 + (explode ? 200 : 0),-wood_w/2+wood_t/2+bed_delta_z])
    {
        translate([0, matress_width/2 + (explode ? 45 : 0), 0]) 
            bedside(matress_length, cw_w, cw_h, jw_w, jw_h, groove_depth); 
      
        translate([0,-matress_width/2 - (explode ? 45 : 0), 0]) 
            rotate([0,0,180]) 
            bedside(matress_length, cw_w, cw_h, jw_w, jw_h, groove_depth); 

        translate([matress_length/2,0, 0]) 
            bedend(matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth, bed_height, true); 

        translate([-matress_length/2,0, 0]) 
            rotate([0,0,180]) 
            bedend(matress_width, cw_w, cw_h, jw_w, jw_h, groove_depth, bed_height, false); 

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
        
        if (show_matress)
        {
            matress_thickness = 14;
            playwood_thickness = 2.54 * 0.75;
            translate([0, 0, (playwood_thickness+matress_thickness)/2 + (explode ? 200 : 0)]) 
                cube([matress_length, matress_width, matress_thickness], center=true); 
        }
        
        if (show_wood_support) 
        {
            translate([0, 0, explode ? 160 : 0]) 
                mattresssupport(matress_length, matress_width); 
        }
    }

    translate([-matress_length/2-wood_t-0.1,0,0])
    bedpipe(gap_washer, wood_t, pipe_diam);
    translate([matress_length/2+wood_t+0.1,0,0])
    rotate([0,0,180])
    bedpipe(gap_washer, wood_t, pipe_diam);
    
    translate([matress_length/2,-wood_t/2,0])
    rotate([0,-90,0])
    hdim(0,bed_delta_z+wood_t/2,0,6);
}

coconutbed();