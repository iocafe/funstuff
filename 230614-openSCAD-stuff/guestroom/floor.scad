
module floor(house_sz, front_cut_diag, toilet_cut_d, floor_thickness=10, transparent_concrete=false)
{
    c = sqrt(2) * front_cut_diag;
    points = [ 
        [0, house_sz[1]], 
        [house_sz[0], house_sz[1]],
        [house_sz[0], toilet_cut_d[1]],
        [house_sz[0] - toilet_cut_d[0], toilet_cut_d[1]],
        [house_sz[0] - toilet_cut_d[0], 0],
        [c, 0],
        [0, c]];
    
    translate([0,0,-floor_thickness])
    //color("Aqua")
    color(transparent_concrete ? [0.6,0.6,0.6,0.4] : [250/255,150/255,58/255, 1.0])
    linear_extrude(floor_thickness)
        polygon(points);

    if (transparent_concrete==false) {
        paint_thickness = 0.1;
        translate([0,0,-paint_thickness/2])
        color("WhiteSmoke")
        linear_extrude(paint_thickness)
            polygon(points);
    }
}

floor(house_sz = [515, 410], front_cut_diag = 60, toilet_cut_d = [170, 139], floor_thickness=10, transparent_concrete=true);
