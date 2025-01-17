module foot(wood_w = 15, gim_t = 4.2, gap = 0.3)
{
    translate([0, 0, -gim_t/2]) 
    {
        color([0.75,0.48,0.19, 1.0])
        cube([gim_t, 2*wood_w+gap, gim_t], center = true);
    }
}        

foot();