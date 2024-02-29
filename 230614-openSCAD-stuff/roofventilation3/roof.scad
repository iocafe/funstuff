module roof(width=200, height=40) 
{
   roofpiece(width/2, height);
   rotate([0,0,90]) roofpiece(width/2, height);
   rotate([0,0,180]) roofpiece(width/2, height);
   rotate([0,0,270]) roofpiece(width/2, height);
}

module roofpiece(width=140, height=120) 
{
    angle = atan(height/width);
    
    hyp = sqrt(width*width + height*height);
 
    color([0,0.9,0.9])
    rotate([0,angle,0])
    linear_extrude(1) 
    polygon(points=[[0,0],[hyp,width], [hyp,-width],[0,0]]);
}

roof();