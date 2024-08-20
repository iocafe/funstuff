module legcup()
{
    diam = 10;
    height = 3;
    wall = 0.8;
    
    difference()
    {
        color([0.33,0.22,0.20, 1.0])
        cylinder(h=height,d=diam,$fn = 22);

        translate([0,0,wall])
        color([0.63,0.42,0.40, 1.0])
        cylinder(h=height,d=diam-2*wall,$fn = 22);
    }
}   

legcup();