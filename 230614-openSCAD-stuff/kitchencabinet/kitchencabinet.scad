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

top_bar_w = 2.5;
top_bar_h = 5.0;
top_bar_t  = 0.3;

electric_box_w = 98; /* Electric box width plus allowance 2cm on left of the box */

pilar_corner_cut = 6.0;

vertical_bar_w = 1.5 * 2.5;
vertical_bar_h = vertical_bar_w;
vertical_bar_t  = 0.3;

cabinet_depth = ss_drying_depth + 2 * bottom_bar_w;

module kitchen_cabinet()
{
    // Bottom level frame *******
    translate([-fridge_cut_w/2,0,0]) 
    rectbar_frame(
        length = cabinet_width - fridge_cut_w, 
        width = cabinet_depth, 
        bar_w = bottom_bar_w,  /* Width */
        bar_h = bottom_bar_h,  /* Height */
        bar_t = bottom_bar_t,  /* Metal thickness */
        c = "red",
        c2 = "darkred",
        corner1_cut = pilar_corner_cut,
        corner2_cut = 0.0,
        electric_box_cut = 0.0,
        explode = explode);

    translate([cabinet_width/2
            - fridge_cut_w 
            - 1.5 * bottom_bar_w, 
            cabinet_depth/2, bottom_bar_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length = cabinet_depth - 2*bottom_bar_w, 
        bar_w = bottom_bar_w,  /* Width */
        bar_h = bottom_bar_h,  /* Height */
        c = "orange");

    translate([-cabinet_width/2
            + 1.5 * bottom_bar_w, 
            (cabinet_depth-pilar_corner_cut)/2, bottom_bar_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length=cabinet_depth 
            - 2*bottom_bar_w 
            - pilar_corner_cut, 
        bar_w = bottom_bar_w,  /* Width */
        bar_h = bottom_bar_h,  /* Height */
        c = "orange");

    // Fridge top level frame *******
    translate([cabinet_width/2-fridge_cut_w/2,0,fridge_cut_h]) 
    rectbar_frame(length = fridge_cut_w, 
        width = cabinet_depth, 
        bar_w = fridgetop_bar_w,  /* Width */
        bar_h = fridgetop_bar_h,  /* Height */
        bar_t = fridgetop_bar_t,  /* Metal thickness */
        c = "red",
        c2 = "darkred",
        corner1_cut = 0.0,
        corner2_cut = pilar_corner_cut,
        electric_box_cut = 0.0,
        explode = explode);

    translate([cabinet_width/2
            - 1.5 * bottom_bar_w, 
            cabinet_depth/2
            - fridgetop_bar_w, 
            fridge_cut_h 
            + fridgetop_bar_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length = cabinet_depth 
            - pilar_corner_cut 
            - 2*fridgetop_bar_w, 
        bar_w = fridgetop_bar_w,  /* Width */
        bar_h = fridgetop_bar_h,  /* Height */
        c = "orange");


    translate([0,0,dish_drying_height + bottom_bar_h]) 
    rectbar_frame(length = cabinet_width, 
        width = cabinet_depth, 
        bar_w = fridgetop_bar_w,  /* Width */
        bar_h = fridgetop_bar_h,  /* Height */
        bar_t = fridgetop_bar_t,  /* Metal thickness */
        c = "red",
        c2 = "darkred",
        corner1_cut = pilar_corner_cut,
        corner2_cut = pilar_corner_cut,
        electric_box_cut = 0.0,
        explode = explode);
        
    // Drying racks *******
    drying_rack_1_x = cabinet_width/2
        - fridge_cut_w
        - 2 * bottom_bar_w
        - ss_drying_width/2;
    translate([drying_rack_1_x,
        cabinet_depth/2, bottom_bar_h])
    drying_rack();
    
    translate([drying_rack_1_x
            - (ss_drying_width + dryrack_sep_w)/2, 
            cabinet_depth/2, 
            bottom_bar_h-dryrack_sep_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length=cabinet_depth 
            - 2*bottom_bar_w, 
        bar_w = dryrack_sep_w,  /* Width */
        bar_h = dryrack_sep_h,  /* Height */
        c = "orange");

    drying_rack_2_x = drying_rack_1_x
        - ss_drying_width - dryrack_sep_w;
    translate([drying_rack_2_x,
        cabinet_depth/2, bottom_bar_h])
    drying_rack();

    translate([drying_rack_2_x
            - (ss_drying_width + dryrack_sep_w)/2, 
            cabinet_depth/2, 
            bottom_bar_h-dryrack_sep_h/2])
        rotate([0,0,90])
    rectbar_simple(
        length=cabinet_depth 
            - 2*bottom_bar_w, 
        bar_w = dryrack_sep_w,  /* Width */
        bar_h = dryrack_sep_h,  /* Height */
        c = "orange");

    // Bottom pans racks *******
    translate([drying_rack_1_x, cabinet_depth/2,1])
    rotate([1.5,-1.5,0])
    bottom_pan(ss_drying_width+1, ss_drying_depth);

    // Top frame *******
    translate([0,0,cabinet_height - top_bar_h]) 
    {
        rectbar_frame(length = cabinet_width, 
            width = cabinet_depth, 
            bar_w = top_bar_w,  /* Width */
            bar_h = top_bar_h,  /* Height */
            bar_t = top_bar_t,  /* Metal thickness */
            c = "red",
            c2 = "darkred",
            corner1_cut = pilar_corner_cut,
            corner2_cut = pilar_corner_cut,
            electric_box_cut = electric_box_w
                - pilar_corner_cut,
            explode = explode);
            
        translate([-cabinet_width/2
                + 1.5 * top_bar_w, 
                (cabinet_depth-pilar_corner_cut)/2,
                top_bar_h/2])
        rotate([0,0,90])
        rectbar_simple(
            length=cabinet_depth 
                - 2*top_bar_w 
                - pilar_corner_cut, 
            bar_w = top_bar_w,  /* Width */
            bar_h = top_bar_h,  /* Height */
            c = "orange");        

        translate([cabinet_width/2
                - 1.5 * top_bar_w, 
                (cabinet_depth
                    - pilar_corner_cut
                    + top_bar_w)/2,
                top_bar_h/2])
        rotate([0,0,90])
        rectbar_simple(
            length=cabinet_depth 
                - top_bar_w 
                - pilar_corner_cut, 
            bar_w = top_bar_w,  /* Width */
            bar_h = top_bar_h,  /* Height */
            c = "orange");        
    }

    // Left long vertical bars *******
    translate([-(cabinet_width
        - vertical_bar_w)/2,
        vertical_bar_h/2,
        (cabinet_height 
        + bottom_bar_h
        - top_bar_h)/2])
    rotate([0,90,0])
    rectbar_simple(
        length=cabinet_height 
            - top_bar_h 
            - bottom_bar_h, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        

    translate([-(cabinet_width
        - vertical_bar_w)/2,
        cabinet_depth 
        - pilar_corner_cut
        - vertical_bar_h/2,
        (cabinet_height 
        + bottom_bar_h
        - top_bar_h)/2])
    rotate([0,90,0])
    rectbar_simple(
        length=cabinet_height 
            - top_bar_h 
            - bottom_bar_h, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        

    // Right long vertical bars *******
    translate([(cabinet_width
        - vertical_bar_w)/2,
        vertical_bar_h/2,
        (cabinet_height 
        + fridge_cut_h
        + fridgetop_bar_h
        - top_bar_h)/2])
    rotate([0,90,0])
    rectbar_simple(
        length=cabinet_height 
            - fridge_cut_h
            - top_bar_h 
            - fridgetop_bar_h, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        

    translate([(cabinet_width
        - vertical_bar_w)/2,
        cabinet_depth 
        - pilar_corner_cut
        - vertical_bar_h/2,
        (cabinet_height 
        + fridge_cut_h
        + fridgetop_bar_h
        - top_bar_h)/2])
    rotate([0,90,0])
    rectbar_simple(
        length=cabinet_height 
            - fridge_cut_h
            - top_bar_h 
            - fridgetop_bar_h, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        
        
    // Short center right bottom vertical bars *******
    translate([(cabinet_width
        - vertical_bar_w)/2
        - fridge_cut_w,
        vertical_bar_h/2,
        dish_drying_height/2 
        + bottom_bar_h])
    rotate([0,90,0])
    rectbar_simple(
        length=dish_drying_height, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        
        
    translate([(cabinet_width
        - vertical_bar_w)/2
        - fridge_cut_w,
        cabinet_depth - vertical_bar_h/2,
        dish_drying_height/2 
        + bottom_bar_h])
    rotate([0,90,0])
    rectbar_simple(
        length=dish_drying_height, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        

    // Short center left bottom vertical bars *******
    translate([cabinet_width/2
        + vertical_bar_w/2
        - fridge_cut_w 
        - 3 * dryrack_sep_w
        - 2 * ss_drying_width,
        vertical_bar_h/2,
        dish_drying_height/2 
        + bottom_bar_h])
    rotate([0,90,0])
    rectbar_simple(
        length=dish_drying_height, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        

    translate([cabinet_width/2
        + vertical_bar_w/2
        - fridge_cut_w 
        - 3 * dryrack_sep_w
        - 2 * ss_drying_width,
        cabinet_depth 
        - vertical_bar_h/2,
        dish_drying_height/2 
        + bottom_bar_h])
    rotate([0,90,0])
    rectbar_simple(
        length=dish_drying_height, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        
        
    // Top center vertical bars *******
    translate([
        + cabinet_width
        - electric_box_w
        - cabinet_width/2
        - vertical_bar_w/2,
        vertical_bar_h/2,
        (cabinet_height - top_bar_h - fridgetop_bar_h - bottom_bar_h - dish_drying_height)/2
        + dish_drying_height 
        + fridgetop_bar_w
        + bottom_bar_h])
    rotate([0,90,0])
    rectbar_simple(
        length=cabinet_height
            - dish_drying_height
            - top_bar_h 
            - fridgetop_bar_h
            - bottom_bar_h, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        
        
    translate([
        + cabinet_width
        - electric_box_w
        - cabinet_width/2
        - vertical_bar_w/2,
        cabinet_depth 
        - vertical_bar_h/2,
        (cabinet_height - top_bar_h - fridgetop_bar_h - bottom_bar_h - dish_drying_height)/2
        + dish_drying_height 
        + fridgetop_bar_w
        + bottom_bar_h])
    rotate([0,90,0])
    rectbar_simple(
        length=cabinet_height
            - dish_drying_height
            - top_bar_h 
            - fridgetop_bar_h
            - bottom_bar_h, 
        bar_w = vertical_bar_h,  /* Width */
        bar_h = vertical_bar_w,  /* Height */
        c = "coral");        
    
    // Electric box placeholder *******
    translate([cabinet_width/2, cabinet_depth, cabinet_height])
    electric_box();
}


kitchen_cabinet();
