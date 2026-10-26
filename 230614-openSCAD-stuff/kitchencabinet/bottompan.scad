default_pan_width = 29.5+1;
default_pan_depth = 26.5;

pan_shoulder_h = 1.6;
pan_metal_t = 0.1;

module bottom_pan(
    pan_width = default_pan_width,
    pan_depth = default_pan_depth)
{
    translate([0,0,0]) 
    {
        color("green")
        difference() 
        {
            cube ([pan_width, 
                pan_depth, pan_shoulder_h], 
                    center = true);
            
            union()
            {    
                translate([0,0,pan_metal_t])
                cube ([pan_width-2*pan_metal_t, 
                    pan_depth-2*pan_metal_t,
                    pan_shoulder_h], 
                    center = true);
                translate([-pan_width/2+1,-pan_depth/2+1,0])
                cylinder(h = pan_shoulder_h+0.2, d = 1.2, $fn=20, center=true);
            }
        }
    }
}

bottom_pan();
