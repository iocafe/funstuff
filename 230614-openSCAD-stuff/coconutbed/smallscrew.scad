module smallscrew(rotation=0) 
{
    screw_width = 0.3;
    screw_length = 4.0;
    end_diameter = 0.7;
    end_length = 0.3;
    sharp_length = 0.3;
  
    points=[
        [0,0],
        [end_diameter/2, 0],
        [screw_width/2, end_length],
        [screw_width/2, end_length+screw_length-sharp_length],
        [0, end_length+screw_length],
        [0,0]
    ];
 
    rotate([0,180,rotation]) 
    color([0.9,0.8,0.2])
    rotate_extrude(convexity = 1, $fn = 14) polygon(points);
    
 
}

smallscrew();