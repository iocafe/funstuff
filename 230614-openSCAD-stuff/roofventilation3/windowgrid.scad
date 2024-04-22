use <Lprofile.scad>
use <gridrod.scad>

module windowgrid(height=60, width=50, lprofile_width=2.54, lprofile_thickness=0.3,n_vertical_bars = 10, explode=true) 
{
    gridrod_width=1.0;
    gridrod_depth=1.0;
    
    nro_vertical_bars = n_vertical_bars;
    nro_horizontal_bars = 2;
    explo_dist = explode ? 6 : 0;
    explo_dist2 = explode ? -10 : 0;

    translate([0,0,-explo_dist])
    lprofile(width, lprofile_width, lprofile_thickness, true) ;

    translate([0,0,height+explo_dist])
    rotate([180,0,180])
    lprofile(width, lprofile_width, lprofile_thickness, true) ;

    translate([width/2+explo_dist,0,height/2])
    rotate([0,270,0])
    lprofile(height, lprofile_width, lprofile_thickness, true) ;
    
    translate([-width/2-explo_dist,0,height/2])
    rotate([0,90,0])
    lprofile(height, lprofile_width, lprofile_thickness, true) ;

    xstep = (width-2.0*(lprofile_width-gridrod_width))/(nro_vertical_bars+1);
    xstart = -xstep * (nro_vertical_bars-1) / 2.0;
    verticalbar_h = height-2*lprofile_width;
    for (x=[0:nro_vertical_bars-1]) {
        xx = xstep * x + xstart;
        translate([xx,-(gridrod_depth-lprofile_thickness)-explo_dist2,
            verticalbar_h/2+lprofile_width])
        rotate([0,270,0])
        gridrod(verticalbar_h, gridrod_width, gridrod_depth);
    }

    ystep = (height-2.0*(lprofile_width-gridrod_width))/(nro_horizontal_bars+1);
    ystart = -ystep * (nro_horizontal_bars-1) / 2.0 + height/2;
    horizontalbar_l = width-2*lprofile_thickness;
    for (y=[0:nro_horizontal_bars-1]) {
        yy = ystep * y + ystart;
        translate([0, lprofile_thickness, yy])
        //rotate([0,270,0])
        gridrod(horizontalbar_l, gridrod_width, gridrod_depth);
    }
}

windowgrid();