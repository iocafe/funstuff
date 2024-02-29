use <selfleg.scad> 
self_width = 200;
self_height = 210;
divs = 2;
self_n_woods = 3;
wood_thickness = 2.1 * 2.54;
wood_width = 6.5 * 2.54;
groove_depth = 1;
groove_height = wood_thickness + 0.5;



module self() 
{
    xstep = (self_width - wood_thickness) / divs;
    for (x=[0:divs])
    {
        xx = x * xstep - (self_width-wood_thickness)/2;
        first_leg = (x == 0);
        last_leg = (x == divs);
        
        translate([xx,0,0])
            selfleg(self_height - wood_thickness, self_n_woods, 
                wood_thickness, wood_width, 
                groove_depth, groove_height, 
                first_leg, last_leg);
    }
}

self();