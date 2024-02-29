use <quarter.scad> 

module extraroof(w = 300, l=150, long_angle=10, short_angle=30) 
{
    hh = l * sin(long_angle);
    short_l = hh/cos(short_angle);
    long_extend = short_l * sin(long_angle) + hh;
    rotate([-long_angle,0,0]) {
        quarter(w, w+long_extend, l);
    }
    rotate([-long_angle,0,180]) {
        quarter(w, w+long_extend, l);
    }
}

extraroof();