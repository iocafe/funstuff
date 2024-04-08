module gridrod(length=100, width=3, depth=1) 
{
    color([0.7,0.2,0.3])
    translate([0,depth/2,0])
    cube([length, depth, width], center=true);
}

gridrod();