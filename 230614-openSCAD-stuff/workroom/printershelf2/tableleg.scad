use <../hdim.scad> 


bar_t  = 0.3;

module tableleg(height = 73.9, width = 56, bar_diam = 3.8, dimensions=true, explode=false, c1 = [0.5,0.28,0.19, 1.0], c2 = [0.8,0.30,0.29, 1.0])
{
    d = explode ? 20 : 0;
   
    
    translate([width,0,0])
    rotate([0,90,90])
    {
    translate([-height,-d,0]) 
    tl_anglebar(height, bar_diam, c1, straight1=true, dims=dimensions);
    translate([0,width+d,0]) 
    rotate([0,0,180])
    tl_anglebar(height, bar_diam, c1, straight2=true, dims=dimensions);
    translate([d,0,0]) 
    rotate([0,0,90])
    tl_anglebar(width, bar_diam, c2, dims=dimensions);
    angle = atan2(width, height);
    len = sqrt(width*width+height*height) - (bar_diam+bar_t)/cos(angle);
    translate([-height/2,width/2,bar_t]) 
    rotate([0,0,-angle])
    translate([-len/2,-bar_diam/2,0]) 
    tl_anglebar(len, bar_diam, c2, straight1=true, straight2=true, dims=dimensions);

    
    hyp = width - 1.41*bar_diam;
    angle2 = -angle+90;
    cat1 = sin(angle)*hyp;
    cat2 = cos(angle)*hyp;
    len2 = cat2 - bar_diam/2;
    
    dx = cat1*cos(angle);
    dy = cat1*sin(angle)+1.25*bar_diam/2;
    translate([-dx,dy,bar_t]) 
    rotate([0,0, angle2])
    translate([len2,4*bar_diam/3,0]) 
    rotate([0,0,180])
    tl_anglebar(len2, bar_diam, c2, straight1=true, straight2=true, dims=dimensions);

    dx2 = height-dx-bar_diam/2-bar_t;
    dy2 = width-dy-bar_diam/2+bar_t;
    translate([-dx2,dy2,bar_t]) 
    rotate([0,0, angle2])
    translate([0,bar_diam/2,0]) 
     rotate([0,0,180])
    tl_anglebar(len2+0.5,bar_diam, c2,straight1=true, straight2=true, dims=dimensions);
    }
}        

module tl_anglebar(height, bar_diam, c, straight1=false, straight2=false, dims=true)
{
   color(c)
    {
        linear_extrude(bar_t) 
        polygon(points=[[0,0],
            [straight1?0:bar_diam, bar_diam],
            [straight2?height:height-bar_diam, bar_diam],
            [height, 0], [0,0]]);
 
        cube([height, bar_t, bar_diam]);
    }
    
    if (dims) {
        hdim(x1 = 0, x2 = height, y = 0, dimline_lenght = 5);
    }
}   


tableleg();