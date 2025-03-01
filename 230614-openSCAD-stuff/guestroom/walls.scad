use <basicdoor.scad>
use <frontdoor.scad>
use <arcdoorhole.scad> 
use <slidingwindow.scad>
use <hdim.scad>

module walls(house_sz, front_cut_diag, toilet_cut_d, bedroom_l = 240,wall_t=15, wall_height=260)
{
    // Colors
    wall_color=[249/255, 252/255, 50/255, 1.0];
    paint_the_rooms = [255/255, 255/255, 255/255, 1.0];
    
    c = sqrt(2) * front_cut_diag;
    sz = house_sz;
    exteriorpoints = [ 
        [0, sz[1]], 
        [sz[0], sz[1]],
        [sz[0], toilet_cut_d[1]],
        [sz[0] - toilet_cut_d[0], toilet_cut_d[1]],
        [sz[0] - toilet_cut_d[0], 0],
        [c, 0],
        [0, c]];

    interiorpoints = [ 
        [wall_t, sz[1] - wall_t], 
        [sz[0] - wall_t, sz[1] - wall_t],
        [sz[0] - wall_t, toilet_cut_d[1] + wall_t],
        [sz[0] - toilet_cut_d[0] - wall_t, toilet_cut_d[1] + wall_t],
        [sz[0] - toilet_cut_d[0] - wall_t, wall_t],
        [c + wall_t/sqrt(2), wall_t],
        [wall_t, c+ wall_t/sqrt(2)]];
 
    painted_wall_t = wall_t + 0.1; 
    paintpoints = [ 
        [painted_wall_t, sz[1] - painted_wall_t], 
        [sz[0] - painted_wall_t, sz[1] - painted_wall_t],
        [sz[0] - painted_wall_t, toilet_cut_d[1] + painted_wall_t],
        [sz[0] - toilet_cut_d[0] - painted_wall_t, toilet_cut_d[1] + painted_wall_t],
        [sz[0] - toilet_cut_d[0] - painted_wall_t, painted_wall_t],
        [c + painted_wall_t/sqrt(2), painted_wall_t],
        [painted_wall_t, c+ painted_wall_t/sqrt(2)]];
  
    color(wall_color)
        linear_extrude(wall_height)
        difference() {
            polygon(exteriorpoints);
            polygon(interiorpoints);
        }

    color(paint_the_rooms)
        linear_extrude(wall_height)
        difference() {
            polygon(interiorpoints);
            polygon(paintpoints);
        }
    
    color(paint_the_rooms)
        translate([sz[0]-wall_t-bedroom_l, sz[1]/2,wall_height/2])
        cube([wall_t, sz[1]-2*wall_t, wall_height], center=true);

    toilet_inside_w = sz[0] - bedroom_l - toilet_cut_d[0] - 1.5*wall_t;
    toilet_inside_d = toilet_cut_d[1] - wall_t;
        
    color(paint_the_rooms)
        translate([sz[0]-(bedroom_l+wall_t)/2 - (bedroom_l - toilet_cut_d[0])/2, toilet_cut_d[1]+painted_wall_t/2,wall_height/2])
        cube([toilet_inside_w, wall_t, wall_height], center=true);
        
    d1 = sz[0] - toilet_cut_d[0] - wall_t;
    hdim(d1 - toilet_inside_w, d1, (toilet_cut_d[1]+wall_t)/2);

    translate([d1-toilet_inside_w/3,wall_t,0])
    rotate([0,0,90])
        hdim(0, toilet_inside_d, 0);
}

// For testing
walls(house_sz = [495, 410], front_cut_diag = 60, toilet_cut_d = [115, 145]);