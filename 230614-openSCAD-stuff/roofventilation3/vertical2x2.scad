module vertical2x2(length=100, wood_width = 4, roof_angle=20, slice=0,slice2=0, slice3=0) 
{
    half_w = wood_width/2;
    cut_depth = wood_width*tan(roof_angle);
    
    difference() 
    {
        color([0.9,0.6,0.3])
        translate([half_w,half_w,0])
        rotate([0,90,180])
        linear_extrude(wood_width) 
        polygon(points=[[0, half_w],
            [length+cut_depth/2,half_w],
            [length-cut_depth/2,-half_w],
            [0, -half_w], [0, half_w]]);
        
        if (slice > 0.001) {
            slice_d = sqrt(2) * slice*1.001;
            translate([-wood_width/2, 0, -0.5 *(length+cut_depth)+0.05])
            rotate([0,0,45])
            cube([slice_d, slice_d, length + cut_depth + 0.1], center=true); 
        }
        
        if (slice2 > 0.001) {
            slice_d2 = sqrt(2) * slice2*1.001;
            translate([wood_width/2, wood_width, -0.5 *(length+cut_depth)+0.05])
            rotate([0,0,45])
            cube([slice_d2, slice_d2, length + cut_depth + 0.1], center=true); 
        }

        if (slice3 > 0.001) {
            slice_d3 = sqrt(2) * slice3*1.001;
            translate([wood_width/2, 0, -0.5 *(length+cut_depth)+0.05])
            rotate([0,0,45])
            cube([slice_d3, slice_d3, length + cut_depth + 0.1], center=true); 
        }
    }
}

vertical2x2();