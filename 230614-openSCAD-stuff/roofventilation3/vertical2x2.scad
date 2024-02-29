module vertical2x2(length=100, wood_width = 4, roof_angle=20) 
{
    half_w = wood_width/2;
    cut_depth = wood_width*tan(roof_angle);
    
    color([0.9,0.6,0.3])
    translate([half_w,0,0])
    rotate([0,90,180])
    linear_extrude(wood_width) 
    polygon(points=[[0, half_w],[length+cut_depth/2,half_w],[length-cut_depth/2,-half_w],[0, -half_w], [0, half_w]]);
}

vertical2x2();