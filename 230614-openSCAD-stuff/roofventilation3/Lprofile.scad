module lprofile(length=100, width=2, thickness=0.5, angle45=true) 
{
    cut_depth = angle45 ? (width-thickness) : 0;
    l = angle45 ? (length-2*thickness) : length;

    color([0.9,0.3,0.3])
    translate([0,width/2,thickness/2])
    cube([l, width, thickness], center=true);
    
    color([0.9,0.3,0.3])
    translate([-l/2,thickness,0])
    rotate([90,0,0])
    linear_extrude(thickness) 
    polygon(points=[[0, 0],[0,thickness],[cut_depth,width],
        [l-cut_depth,width],[l,thickness],[l,0],
        [0,0]]);
}

lprofile();