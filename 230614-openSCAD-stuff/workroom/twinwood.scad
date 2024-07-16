use <hdim.scad> 
use <ironbrace.scad> 
use <hdim.scad> 

module twinwood(wood_l = 120, wood_w = 16, wood_t = 4.5, gap = 0.3, n_braces = 3, explode=false, show_brace_dims=false,
    hole_1_x = -10000, hole_2_x = -10000, hole_3_x = -10000,
    show_hole_pos = true)
{
    bolthole_diam = 1.4;

    if (hole_1_x < -1000 && hole_2_x < -1000 && hole_3_x < -1000)
    {
        twinwood2(wood_l, wood_w, wood_t, gap, 
            n_braces, explode, show_brace_dims);
    }
    else 
    {
        difference() {
            twinwood2(wood_l, wood_w, wood_t, gap, 
                n_braces, explode, show_brace_dims);
            
            if (hole_1_x > -1000) {
                translate([-wood_l/2 + wood_t/2,
                    wood_w/2 + gap/2, wood_t/2])
                cylinder(h = wood_t + 2, d = bolthole_diam, 
                    center = true, $fn=18);

                translate([-wood_l/2 + wood_t/2, 
                    -wood_w/2 - gap/2, wood_t/2])
                cylinder(h = wood_t + 2, d = bolthole_diam, 
                    center = true, $fn=18);
            }
            
            if (hole_2_x > -1000) {
                translate([wood_l/2 - wood_t/2,
                    wood_w/2 + gap/2, wood_t/2])
                cylinder(h = wood_t + 2, d = bolthole_diam, 
                    center = true, $fn=18);

                translate([wood_l/2 - wood_t/2, 
                    -wood_w/2 - gap/2, wood_t/2])
                cylinder(h = wood_t + 2, d = bolthole_diam, 
                    center = true, $fn=18);
            }
        }
        
        if (hole_1_x > -1000 && show_hole_pos) {
            translate([-wood_l/2 + wood_t/2, wood_w/2 + gap/2, wood_t])
            rotate([0,0,270])
            hdim(0, wood_w + gap/2, 0, 9);

            translate([-wood_l/2, -wood_w/2 - gap/2, wood_t])
            // rotate([0,0,270])
            hdim(0, wood_t/2, 0, 9);
        }
    }
}

module twinwood2(wood_l = 120, wood_w = 16, wood_t = 4.5, gap = 0.3, n_braces = 3, explode=false, show_brace_dims=false)
{
    wood_y = wood_w/2+gap/4;

    translate([0, wood_y, wood_t/2])
        tw_onewood(wood_l, wood_w, wood_t, gap, explode);

    translate([0, -wood_y, wood_t/2])
        tw_onewood(wood_l, wood_w, wood_t, gap, explode);
    
    translate([-wood_l/5,0,0]) 
    rotate([0,180,0])
    text(str(0.1 * round(10*wood_l)), size = 10, 
        halign = "center",valign = "center");
    translate([-wood_l/5,0,wood_t]) 
    text(str(0.1 * round(10*wood_l)), size = 10, 
        halign = "center",valign = "center");

    first_brace = 14;
    brace_step = (wood_l-2*first_brace) / (n_braces-1);
    brace_z = explode ? -7 : 0;
    
    for (i=[0:n_braces-1])
    {
        brace_x = -wood_l/2 + first_brace + i * brace_step;
        
        translate([brace_x, 0, brace_z]) 
        ironbrace(2*wood_w+gap, show_brace_dims && (i == 0));
    }
}        

module tw_onewood(wood_l, wood_w, wood_t, gap, explode)
{
    red = rands(0.7,0.90,1)[0];
    color([red,0.48,0.19, 1.0])
    translate([0,0,0])
    cube([wood_l, wood_w, wood_t], center=true);
}   

twinwood();