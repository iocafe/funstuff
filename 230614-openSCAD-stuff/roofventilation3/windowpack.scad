// Metal grid and storm blind hatch
use <windowblind.scad>
use <windowgrid.scad>
use <hinge.scad>

module windowpack(height=60, width=50, lprofile_width=2.54, lprofile_thickness=0.3,open_angle = 100, explode=false) 
{
    hinge_separation = 0.6;
    hinge_pos_adjust = 0.3;
    explo_dist = explode ? 14 : 0;
    
    windowgrid(height, width, lprofile_width, lprofile_thickness, explode); 
    
    rota_pos = height + hinge_separation*0.5;
    
    translate([0, -explo_dist, rota_pos])
    rotate([-open_angle,0,0])
    translate([0, -lprofile_width-hinge_separation, -rota_pos])
    windowblind(height, width, lprofile_width, lprofile_thickness, explode); 
    
    if (!explode)
    {
        hinge_distance_from_edge = 4;
        translate([width/2-hinge_distance_from_edge, 
            -hinge_separation/2, height+   hinge_pos_adjust])
        hinge(open_angle);
    
        translate([-width/2+hinge_distance_from_edge, 
            -hinge_separation/2, height+hinge_pos_adjust])
        hinge(open_angle);
    }
}        

windowpack();