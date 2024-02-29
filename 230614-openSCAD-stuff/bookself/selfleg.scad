module selfleg(leg_length =205, self_n_woods=4, 
    wood_thickness=5, wood_width=15, 
    groove_depth=1, groove_height = 6, 
    first_leg=false, last_leg=false)
{
    self_depth = wood_width * self_n_woods;
    
    translate([0,0,leg_length/2])
    {
        difference()
        {
            for (y = [0:self_n_woods-1])
            {
                yy = y * wood_width - self_depth/2 + wood_width/2; 
                
                color([0.01 * rands(60,80,1)[0],
                    0.01 * rands(30,50,1)[0],
                    0.01 * rands(0,20,1)[0]])
                translate([0,yy,0])
                cube([wood_thickness, wood_width, leg_length],center=true);
            }
        
            if (!last_leg) {
                translate([wood_thickness/2-groove_depth/2,0,0])
                color([0.5,0.3,0.1])
                    cube([groove_depth+0.1, self_depth+0.1, 
                        groove_height],center=true);
            }
        }
    }
}

selfleg();