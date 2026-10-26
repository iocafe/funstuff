rack_width = 29.5;
rack_depth = 26.5;
rack_height = 3;
rack_wall_t = 0.3;
wire_w = 0.3;
shoulder_w = 0.7;
shoulder_h = 0.7;

module drying_rack()
{
    color("silver")
    translate([0,0,-rack_height/2+shoulder_h]) 
    {
        difference() 
        {
            union() {
                cube ([rack_width, 
                    rack_depth, rack_height], 
                    center = true);
                
                translate([0,0,rack_height/2-shoulder_h/2])
                cube ([rack_width + 2 * shoulder_w, 
                    rack_depth + 2 * shoulder_w,
                    shoulder_h], 
                    center = true);
            }
            
            cube ([rack_width-2*rack_wall_t, 
                rack_depth - 2*rack_wall_t, 
                rack_height+0.2], 
                center = true);
        }
        
        n = 5;
        step = rack_depth/n;
        for (i = [-(n-1)/2:(n-1)/2])
        {
            translate([0, i*step, -rack_height/2+wire_w])
            rotate([0,90,0])
            cylinder(h = rack_width, 
                d = wire_w, center = true);
        }

        n2 = 7;
        step2 = rack_width/n2;
        for (j = [-(n2-1)/2:(n2-1)/2])
        {
            translate([j*step2, 0, -rack_height/2+wire_w])
            rotate([90,0,0])
            cylinder(h = rack_depth, 
                d = wire_w, center = true);
        }
    }
}

drying_rack();
