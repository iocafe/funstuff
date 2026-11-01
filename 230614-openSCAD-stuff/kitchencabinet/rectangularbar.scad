use <hdim.scad> 

default_bar_w = 5.0;
default_bar_h = 2.5;
default_bar_t  = 0.3;
explode_d = 25;

module rectbar_frame(length = 60, 
    width = 40, 
    bar_w = default_bar_w,  /* Width */
    bar_h = default_bar_h,  /* Height */
    bar_t = default_bar_t,  /* Metal thickness */
    c = "red",              /* Color 1 */
    c2 = "darkred",         /* Color 2 */
    corner1_cut = 6.0,
    corner2_cut = 6.0,
    electric_box_cut = 0,  /* Electric box cut */ 
    explode = false)        
{
    d = explode ? explode_d : 0;

    rectbar_single(length, 
        bar_w, bar_h, bar_t, c, 
        -1, -1, explode);
    
    translate([-length/2-d,width/2-corner1_cut/2,0]) 
    rotate([0,0,-90])
    rectbar_single(width-corner1_cut, 
        bar_w, bar_h, bar_t, c2, 
        -1, -1, explode);
    
    translate([-length/2+corner1_cut/2-d/2,
            width - corner1_cut,0]) 
    rotate([0,0,180])
    rectbar_single(corner1_cut, 
        bar_w, bar_h, bar_t, c, 
        1, -1, explode);

    translate([-length/2+corner1_cut,
        width-corner1_cut/2+d/2,0]) 
    rotate([0,0,-90])
    rectbar_single(corner1_cut, 
        bar_w, bar_h, bar_t, c2, 
        -1, 1, explode);

    if (electric_box_cut <= 0)
    {
        translate([(corner1_cut-corner2_cut)/2,
            width+d,0]) 
        rotate([0,0,180])
        rectbar_single(length 
            - corner1_cut - corner2_cut, 
            bar_w, bar_h, bar_t, c, 
            -1, -1, explode);

        translate([length/2+d,
            width/2-corner2_cut/2,0]) 
        rotate([0,0,90])
        rectbar_single(width-corner2_cut, 
            bar_w, bar_h, bar_t, c2, 
            -1, -1, explode);

        translate([length/2-corner2_cut/2+d/2,
                width - corner2_cut,0]) 
        rotate([0,0,180])
        rectbar_single(corner2_cut, 
            bar_w, bar_h, bar_t, c, 
            -1, 1, explode);

        translate([length/2-corner2_cut,
            width-corner2_cut/2+d/2,0]) 
        rotate([0,0,90])
        rectbar_single(corner2_cut, 
            bar_w, bar_h, bar_t, c2, 
            1, -1, explode); 
    }
    else {
        translate([length/2+d,
            width/2-corner2_cut/2,0]) 
        rotate([0,0,90])
        rectbar_single(width-corner2_cut, 
            bar_w, bar_h, bar_t, c2, 
            -1, 0, explode);

        translate([length/2+d - electric_box_cut - corner2_cut,
            width/2+bar_w/2,0]) 
        rotate([0,0,90])
        rectbar_single(width-bar_w, 
            bar_w, bar_h, bar_t, c2, 
            0, -1, explode);

        translate([(corner1_cut 
            - corner2_cut - electric_box_cut)/2,
            width+d,0]) 
        rotate([0,0,180])
        rectbar_single(length
            - corner1_cut 
            - corner2_cut 
            - electric_box_cut, 
            bar_w, bar_h, bar_t, c, 
            -1, -1, explode);
    }
       
} 

module rectbar_single(length = 50, 
    bar_w = default_bar_w,  /* Width */
    bar_h = default_bar_h,  /* Height */
    bar_t = default_bar_t,  /* Metal thickness */
    c = "red",              /* Color */
    extend_cut1 = -1,       /* -1=shorten, 1=lengthen, 0=flat cut */
    extend_cut2 = -1,
    show_dims = false)
{
    rectbar_helper(length, 
        bar_w, bar_h, bar_t, c,
        extend_cut1, extend_cut2);

    translate([0, 0, bar_h - bar_t])
    {
        rectbar_helper(length, 
            bar_w, bar_h, bar_t, c,
            extend_cut1, extend_cut2);
        
        if (show_dims) {
            hdim(-length/2, length/2, 0, 3);
        }
    }
    
    color(c)
    {
        x = -length/2;
        l = length;
        
        translate([x, 0, bar_t])
        cube([l, bar_t, bar_h-2*bar_t]);
        
        dx1 = extend_cut1 * bar_w;
        dx2 = extend_cut2 * bar_w;
        l2 = l + dx1 + dx2;

        translate([x-dx1, bar_w-bar_t, bar_t])
        cube([l2, bar_t, bar_h-2*bar_t]);
    }
}

module rectbar_helper(length = 50, 
    bar_w = default_bar_w,  /* Width */
    bar_h = default_bar_h,  /* Height */
    bar_t = default_bar_t,  /* Metal thickness */
    c = "red",              /* Color */
    extend_cut1 = -1,
    extend_cut2 = -1)
{
    color(c) 
    {
        translate([-length/2, 0, 0])
        {
            dx1 = extend_cut1 * -bar_w;
            dx2 = extend_cut2 * bar_w;
            linear_extrude(bar_t) 
            polygon(points=[[0,0],
                [dx1, bar_w],
                [length+dx2, bar_w],
                [length, 0], [0,0]]);
        }
    }
}   

module rectbar_simple(length = 60, 
    bar_w = default_bar_w,  /* Width */
    bar_h = default_bar_h,  /* Height */
    c = "orange")
{
    color(c) 
    {
        cube([length, bar_w, bar_h], center = true);
    }
}

rectbar_frame();
// rectbar_single(50, default_bar_w, default_bar_h, default_bar_t, "red", -1, -1, true);
// rectbar_helper();
// rectbar_simple();