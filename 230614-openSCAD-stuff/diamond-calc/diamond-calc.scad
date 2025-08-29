use <hdim.scad> 

default_bar_diam = 2.54;
diamond_width = 20.3;
diamond_height = 45;
diamond_step = 20;
default_frame_height = 2*diamond_height - diamond_step+2*default_bar_diam;

module framed_double_diamond(
    frame_width = diamond_width,
    frame_height = default_frame_height,
    width = diamond_width,
    height = diamond_height,
    step = diamond_step,
    bar_diam = default_bar_diam, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0])
{
    big_w = frame_width + 2*bar_diam;
    big_h = frame_height + 2*bar_diam;
    
    hdim(-big_w/2, big_w/2, big_h/2, -10); 
    
    rotate([0,0,90])
    hdim(-big_h/2, big_h/2, big_w/2, -20); 
    
    double_diamond(width, height,
         step, bar_diam, c1, c2);

    color([0.8,0.30,0.29, 0.6])
    difference() {
        cube([big_w, big_h, 
            bar_diam], center = true);

        cube([frame_width,
            frame_height, 
            bar_diam+0.2], center = true);
    }
}
    
module double_diamond(width = diamond_width,
    height = diamond_height,
    step = diamond_step,
    bar_diam = default_bar_diam, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0])
{
    translate([0,-step/2,0]) 
    diamond(width, height, bar_diam, c1, c2);
 
    translate([0,step/2,0]) 
    diamond(width, height, bar_diam, c1, c2);

    rotate([0,0,90])
    hdim(-step/2, step/2, width/2, -10); 
    
    hdim(-width/2, width/2, -step/2, height/2+step/2+3); 

    rotate([0,0,90])
    hdim(-height/2+step/2, height/2+step/2, 0, width/2+12); 

    rotate([0,0,90])
    hdim(-height/2-step/2, height/2+step/2, 0, width/2+22); 
}


module diamond(width = diamond_width,
    height = diamond_height,
    bar_diam = default_bar_diam, 
    c1 = [0.5,0.28,0.19, 1.0], 
    c2 = [0.8,0.30,0.29, 1.0])
{
    dx = width/4;
    dy = height/4;
    
    angle = atan2(height, width);
    length = sqrt(width*width + height*height) / 2;
      
    translate([dx,-dy,0]) 
    rotate([0,0,angle]) 
    {
        one_piece(length, bar_diam, 
            angle, 90-angle, c1);
        
        hdim(-length/2, length/2, 0, 10);
    }

    translate([-dx,-dy,0]) 
    rotate([0,0,-angle]) 
    one_piece(length, bar_diam, 
        90-angle, angle, c2);

    translate([-dx,dy,0]) 
    rotate([0,0,180+angle]) 
    one_piece(length, bar_diam, 
        angle, 90-angle, c1);

    translate([dx,dy,0]) 
    rotate([0,0,180-angle]) 
    one_piece(length, bar_diam, 
        90-angle, angle, c2);

    color(c1)
        translate([7*dx, 0, 0])
    text(size = 4, str("cut angles ", 0.1*round(10*angle), ", ", 0.1*round(10*(90-angle))));
}        

module one_piece(length, 
    bar_diam, 
    angle_1,
    angle_2,
    c = [1,0,0,1])
{
    translate([-length/2,0,-bar_diam/2])
    color(c) 
    {
        cut_1 = bar_diam * tan(angle_1);
        cut_2 = bar_diam * tan(angle_2);
        linear_extrude(bar_diam) 
        polygon(points=[[0,0],
            [cut_1, bar_diam],
            [length-cut_2, bar_diam],
            [length, 0], [0,0]]);
    }
}   

// one_piece(30, 2.54, 10, 80);
// diamond();
framed_double_diamond();