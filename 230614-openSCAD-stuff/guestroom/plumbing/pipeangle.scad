
module pipeangle(
    angle = 45, 
    pipe_d = 2 * 2.54, 
    end_cap_d = 2.3 * 2.54,
    end_cap_l = 3,
    curve_r = 10,
    pipe_t = 0.5)
{
    translate([-curve_r, 0,0]) {
        rotate_extrude(angle=angle, $fn = 40)
        translate([curve_r,0,0])
        difference() {
            circle(d = pipe_d); 
            circle(d = pipe_d-2*pipe_t); 
        }
        
        endcap(end_cap_d, end_cap_l, pipe_t, curve_r, false);
        
        rotate([0,0,angle])
        endcap(end_cap_d, end_cap_l, pipe_t, curve_r, true);
    }
}

module endcap(
    end_cap_d = 2.5 * 2.54,
    end_cap_l = 3,
    pipe_t = 0.5,
    curve_r = 10,
    other_end=false)
{
    translate([curve_r, other_end ? end_cap_l : 0, 0])
    rotate([90,0,0])
    difference() {
        cylinder(d = end_cap_d, 
            h = end_cap_l, $fn = 40);
        
        translate([0,0,-0.1])
        cylinder(d = end_cap_d-2*pipe_t, 
            h = end_cap_l+0.2, $fn = 40);
    }
}

module ppr90()
{
    pipeangle(angle = 90, 
        pipe_d = 4.4, 
        end_cap_d = 4.4,
        end_cap_l = 1,
        curve_r = 2.3,
        pipe_t = 0.6);
}

module ppr45()
{
    pipeangle(angle = 45, 
        pipe_d = 4.4, 
        end_cap_d = 4.4,
        end_cap_l = 1,
        curve_r = 2.3,
        pipe_t = 0.6);
}

// For testing
//pipeangle(angle = 45);
//ppr90();
ppr45();