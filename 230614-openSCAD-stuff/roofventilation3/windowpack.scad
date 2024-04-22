// Metal grid and storm blind hatch
use <windowblind.scad>
use <windowgrid.scad>
use <hinge.scad>

module windowpack(height=60, width=50, lprofile_width=2.54, lprofile_thickness=0.3,open_angle = 100, n_vertical_bars = 10, explode=false) 
{
    hinge_separation = 0.6;
    hinge_pos_adjust = 0.3;
    explo_dist = explode ? 14 : 0;
    nro_hinges = 6;
    
    windowgrid(height, width, lprofile_width, lprofile_thickness, n_vertical_bars, explode); 
    
    rota_pos = height + hinge_separation*0.5;
    
    translate([0, -explo_dist, rota_pos])
    rotate([-open_angle,0,0])
    translate([0, -lprofile_width-hinge_separation, -rota_pos])
    windowblind(height, width, lprofile_width, lprofile_thickness, explode); 
    
    if (!explode)
    {
        hinge_distance_from_edge = 4;
        first_hinge = -width/2+hinge_distance_from_edge;
        hinge_step = (width - 2 * hinge_distance_from_edge) / (nro_hinges - 1);
        
        for (x = [0:nro_hinges - 1]) {
            translate([first_hinge + x * hinge_step, 
                -hinge_separation/2, height+hinge_pos_adjust])
            hinge(open_angle);
        }
        
        /* translate([-width/2+hinge_distance_from_edge, 
            -hinge_separation/2, height+hinge_pos_adjust])
        hinge(open_angle); */
    }
}        

windowpack();