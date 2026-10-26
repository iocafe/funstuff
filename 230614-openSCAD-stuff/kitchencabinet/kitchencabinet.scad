use <rectangularbar.scad> 
use <dryingrack.scad> 
use <bottompan.scad> 
use <electricbox.scad> 

explode = false;

cabinet_width = 188;
cabinet_height = 105;

fridge_cut_w = 63;
fridge_cut_h = 10;

ss_drying_width = 29.5;
ss_drying_depth = 26.5;

dish_drying_height = 33;
dryrack_sep_w = 5;
dryrack_sep_h = 2.5;

bottom_bar_w = 2.5;
bottom_bar_h = 5.0;
bottom_bar_t  = 0.3;

fridgetop_bar_w = 2.5;
fridgetop_bar_h = 2.50;
fridgetop_bar_t  = 0.3;

pilar_corner_cut = 6.0;

cabined_depth = ss_drying_depth + 2 * bottom_bar_w;

module kitchen_cabinet()
{
    translate([-fridge_cut_w/2,0,0]) 
    rectbar_frame(
        length = cabinet_width - fridge_cut_w, 
        width = cabined_depth, 
        bar_w = bottom_bar_w,  /* Width */
        bar_h = bottom_bar_h,  /* Height */
        bar_t = bottom_bar_t,  /* Metal thickness */
        c = "red",
        c2 = "darkred",
        corner1_cut = pilar_corner_cut,
        corner2_cut = 0.0,
        explode = explode);

    translate([cabinet_width/2
            - fridge_cut_w 
            - 1.5 * bottom_bar_w, 
            cabined_depth/2, bottom_bar_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length = cabined_depth - 2*bottom_bar_w, 
        bar_w = bottom_bar_w,  /* Width */
        bar_h = bottom_bar_h,  /* Height */
        c = "orange");

    translate([-cabinet_width/2
            + 1.5 * bottom_bar_w, 
            (cabined_depth-pilar_corner_cut)/2, bottom_bar_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length=cabined_depth 
            - 2*bottom_bar_w 
            - pilar_corner_cut, 
        bar_w = bottom_bar_w,  /* Width */
        bar_h = bottom_bar_h,  /* Height */
        c = "orange");

    translate([cabinet_width/2-fridge_cut_w/2,0,fridge_cut_h]) 
    rectbar_frame(length = fridge_cut_w, 
        width = cabined_depth, 
        bar_w = fridgetop_bar_w,  /* Width */
        bar_h = fridgetop_bar_h,  /* Height */
        bar_t = fridgetop_bar_t,  /* Metal thickness */
        c = "red",
        c2 = "darkred",
        corner1_cut = 0.0,
        corner2_cut = pilar_corner_cut,
        explode = explode);


    translate([0,0,dish_drying_height + bottom_bar_h]) 
    rectbar_frame(length = cabinet_width, 
        width = cabined_depth, 
        bar_w = fridgetop_bar_w,  /* Width */
        bar_h = fridgetop_bar_h,  /* Height */
        bar_t = fridgetop_bar_t,  /* Metal thickness */
        c = "red",
        c2 = "darkred",
        corner1_cut = pilar_corner_cut,
        corner2_cut = pilar_corner_cut,
        explode = explode);
        
    // Drying racks *******
    drying_rack_1_x = cabinet_width/2
        - fridge_cut_w
        - 2 * bottom_bar_w
        - ss_drying_width/2;
    translate([drying_rack_1_x,
        cabined_depth/2, bottom_bar_h])
    drying_rack();
    
    translate([drying_rack_1_x
            - (ss_drying_width + dryrack_sep_w)/2, 
            cabined_depth/2, 
            bottom_bar_h-dryrack_sep_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length=cabined_depth 
            - 2*bottom_bar_w, 
        bar_w = dryrack_sep_w,  /* Width */
        bar_h = dryrack_sep_h,  /* Height */
        c = "orange");

    drying_rack_2_x = drying_rack_1_x
        - ss_drying_width - dryrack_sep_w;
    translate([drying_rack_2_x,
        cabined_depth/2, bottom_bar_h])
    drying_rack();

    // Bottom pans racks *******
    translate([drying_rack_1_x, cabined_depth/2,1])
    rotate([1.5,-1.5,0])
    bottom_pan(ss_drying_width+1, ss_drying_depth);
    
    // Electric box placeholder *******
    translate([cabinet_width/2, cabined_depth, cabinet_height])
    electric_box();
}


kitchen_cabinet();
