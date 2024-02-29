
module quarter(top_w = 300, bottom_w=500, l=150) 
{
    metal_thickness = 2;
    n_horizontal_beams = 5;
    horizontal_beam_w = 1.7 * 2.56;
    horizontal_beam_h = 20;
    
    points = [[-top_w/2, 0], [top_w/2, 0], [bottom_w/2, l], [-bottom_w/2, l]];
    
    linear_extrude(height = metal_thickness, center = false)
        polygon(points, convexity = 1);
    
    mystep = (l-horizontal_beam_w)/n_horizontal_beams;
    coeff = (bottom_w-top_w)/l;
    for (x = [mystep:mystep:l]) {
        translate([0,x+horizontal_beam_w/2,-horizontal_beam_h/2])
            cube([top_w+x*coeff, horizontal_beam_w, horizontal_beam_h], center=true);
     }
    
}

quarter();