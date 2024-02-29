
module playwood(width=50, height=100, playwood_thickness = 1.5, roof_angle=20) 
{
    cut_depth = width*tan(roof_angle);
    
    color([0.9,0.9,0.9,0.6])
    translate([playwood_thickness,0,0])
    rotate([90,180,270])
    linear_extrude(playwood_thickness) 
    polygon(points=[[0, 0], [width,0], [width,height-cut_depth], [0, height], [0, 0]]);
}

playwood();