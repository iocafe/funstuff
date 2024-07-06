use <hdim.scad> 

module ironbrace(shelf_depth = 32.3, show_dims = false)
{
    if (false) {
        anglebar_ironbrace(shelf_depth, show_dims);
    }
    else {
        flat_ironbrace(shelf_depth, show_dims);
    }
}

module flat_ironbrace(shelf_depth, show_dims = false)
{
    brace_w = 4;
    brace_t = 0.3;
    brace_d1 = 0.7;
    brace_d2 = 0.7;
    n_screw_holes = 4;
    brace_l = shelf_depth - brace_d1 - brace_d2;
    screw_end_d = 1.5;
    screw_range = brace_l - 2*screw_end_d;
    screw_step = screw_range/(n_screw_holes-1);
    first_screw = -screw_range/2;
    screw_hole_diam = 0.6;

    translate([0,(shelf_depth-brace_l)/2-brace_d1,-brace_t/2])
    difference()
    {
        color([0.23,0.12,0.10, 1.0])
        cube([brace_w, brace_l, brace_t], center=true);
        
        for (x = [0: n_screw_holes-1]) {
            xx = x * screw_step + first_screw;
            translate([0, xx, 0])
            cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
            
        }
    }

    if (show_dims) 
    {
        translate([0, -brace_l/2, 0])
            
        for (x = [0: n_screw_holes-1]) {
            xx = x * screw_step + first_screw;
            translate([0, 0, (xx+first_screw)/9-0.2])
            rotate([0,0,90])
            hdim(0, x * screw_step+screw_end_d, -brace_w/2 - 0.3, 4+xx/4);
        }
    }
}

module anglebar_ironbrace(shelf_depth, show_dims = false)
{
    bar_diam = 3.8;
    bar_t  = 0.3;
    
    brace_d1 = 1;
    brace_d2 = 1;
    brace_l = shelf_depth - brace_d1 - brace_d2;
    n_screw_holes = 4;
    screw_range = brace_l - 3;
    screw_step = screw_range/(n_screw_holes-1);
      
    color([0.8,0.3,0.2,1])
    {
        //difference()
        {
            union() {
                linear_extrude(bar_t) 
                polygon(points=[[0,0],
                    [bar_diam, bar_diam],
                    [brace_l-bar_diam, bar_diam],
                    [brace_l, 0], [0,0]]);
 
                cube([brace_l, bar_t, bar_diam]);
            }
            
            for (x = [0: n_screw_holes-1]) {
                translate([x * screw_step + first_screw, brace_d1/20])
                cylinder(h=brace_t+0.5,r=screw_hole_diam/2,center = true, $fn = 16);
            }
        }
    }}

ironbrace(32.3, true);