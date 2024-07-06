module twoboltholes(wood_w = 16, gap = 0.3) 
{
    bolthole_diameter = 1.4;
    max_wood_t = 5.5;
    color([0.7,0.1,0.1,1.0])
    {
        translate([0,(wood_w + gap/2)/2,0]) 
        cylinder(h=max_wood_t, r=bolthole_diameter/2, $fn = 16, center=true);
              
        translate([0,(-wood_w - gap/2)/2,0]) 
        cylinder(h=max_wood_t, r=bolthole_diameter/2, $fn = 16, center=true);  
    }
}

twoboltholes();