use <../hdim.scad> 

box_l = 32; // Depth max 32.5
opening = 54.2; // opening 53.0, 53.2, 54.0, 54.2 

slider_t = 1; // thickness
slider_w = 4.3; // width
slider_l = 30; // length
slider_m = slider_l; // movement

box_w = opening - 2*slider_t; 
box_h = 12;
plywood_t = 1.9;


module drawer(open = false)
{
  explode = false;
  final_view = false;
  
  edelta = explode ? 12 : 0;
  opaque10 = final_view ? 0 : 0.1;
    
  translate([open?slider_m:0,0,0])
  {  
    color([51/255, 34/255, 6/255, 1-opaque10]) 
    translate([-plywood_t/2,0,plywood_t/2])
    cube([box_l-plywood_t, box_w, plywood_t], center=true);
    
    if (!final_view) {
        hdim(-box_l/2, box_l/2-plywood_t, box_w/2, -2);
        rotate([0,0,90]) 
        hdim(-box_w/2, box_w/2, box_l/2, -5);
    }

    cover_over = 0.7;
    
    color([71/255, 44/255, 16/255, 1-2*opaque10]) {
        translate([-box_l/2+plywood_t/2-edelta,0,box_h/2+plywood_t/2])
        cube([plywood_t, box_w, box_h-plywood_t],
            center=true);
        
        translate([box_l/2-plywood_t/2+edelta,0,box_h/2])
        cube([plywood_t, box_w+2*cover_over, box_h],
            center=true); 
    }

    dim1 = (box_l - 2*plywood_t)/2;
    dim2 = (box_h - plywood_t)/2;
    dim3 = box_h/2;

    if (!final_view) {
        translate([0, -edelta, box_h/2+plywood_t/2]) 
        rotate([0,0,180]) 
        hdim(-dim1, dim1, box_w/2, -5);
        
        translate([0, -edelta-box_w/2+plywood_t/2,
            box_h/2+plywood_t/2]) 
        rotate([0,90,90]) 
        hdim(-dim2, dim2, -dim1, 5);
    }
    color([91/255, 78/255, 66/255, 1-2*opaque10]) {
        translate([0,box_w/2-plywood_t/2+edelta,
            box_h/2+plywood_t/2])
        cube([box_l - 2*plywood_t, plywood_t,
            box_h-plywood_t], center=true);
        
        translate([0,-box_w/2+plywood_t/2-edelta,
            box_h/2+plywood_t/2])
        cube([box_l - 2*plywood_t, plywood_t, 
            box_h-plywood_t], center=true);
    }
    
    if (!final_view) {
        translate([0,0,box_h/2+plywood_t/2])
        rotate([0,0,90]) 
        hdim(-box_w/2-cover_over, 
            box_w/2+cover_over, 
            -box_l/2-edelta, 7); 
        
        translate([edelta+box_l/2-plywood_t/2,
        0, box_h/2]) 
        rotate([0,90,-90]) hdim(-dim3, dim3, 0, -4);
    }
    
    translate([-slider_l + box_l/2 - plywood_t, 
        box_w/2, box_h-slider_w]) 
    slider(open);
    
    translate([-slider_l + box_l/2 - plywood_t, 
        -box_w/2, box_h-slider_w]) 
    mirror([0,1,0]) 
    slider(open);
  }
}        

module slider(open = false)
{
    color([122/255, 162/255, 214/255, 1]) 
    cube([slider_l, slider_t/2, slider_w], center = false);

    translate([open?-slider_m:0,slider_t/2,0])
    color([192/255, 192/255, 255/255, 1]) 
    cube([slider_l, slider_t/2, slider_w], center = false);}



drawer();