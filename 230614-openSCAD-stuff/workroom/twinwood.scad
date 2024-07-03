use <hdim.scad> 

module twinwood(wood_l = 120, wood_w = 16, wood_t = 4.5, gap = 0.3, n_braces = 3, explode=false)
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
        tw_flat_ironbrace(2*wood_w+gap);
    }
}        

module tw_onewood(wood_l, wood_w, wood_t, gap, explode)
{
    red = rands(0.7,0.90,1)[0];
    color([red,0.48,0.19, 1.0])
    translate([0,0,0])
    cube([wood_l, wood_w, wood_t], center=true);
}   

module tw_flat_ironbrace(shelf_depth)
{
    brace_w = 4;
    brace_t = 0.3;
    brace_d1 = 1;
    brace_d2 = 1;
    n_screw_holes = 4;
    brace_l = shelf_depth - brace_d1 - brace_d2;
    screw_range = brace_l - 3;
    screw_step = screw_range/(n_screw_holes-1);
    first_screw = -screw_range/2;
    screw_hole_diam = 0.6;

    translate([0,(sheld_depth-brace_l)/2-brace_d1+brace_d2,-brace_t/2]) difference()
    {
        color([0.23,0.12,0.10, 1.0])
        cube([brace_w, brace_l, brace_t], center=true);
        
        for (x = [0: n_screw_holes-1]) {
            translate([0,x * screw_step + first_screw, 0])
            cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
        }
    }
}

twinwood();