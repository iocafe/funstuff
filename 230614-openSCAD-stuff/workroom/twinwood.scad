use <hdim.scad> 
use <ironbrace.scad> 

module twinwood(wood_l = 120, wood_w = 16, wood_t = 4.5, gap = 0.3, n_braces = 3, explode=false, show_dims=false)
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
        ironbrace(2*wood_w+gap, show_dims && (i == 0));
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