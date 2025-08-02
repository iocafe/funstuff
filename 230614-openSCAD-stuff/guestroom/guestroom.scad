use <floor.scad> 
use <walls.scad> 
use <foundation/foundation.scad> 
use <plumbing/plumbing.scad>
use <roof/roof.scad>
use <toiletseat.scad>
use <bathroomsink.scad>
// Top beam with match hollow block, metal C 8 cm wide, height 20


show_furniture = true;

// Transparent concrete in walls and floor allows to
// see support structure, electrical connections and piping
transparent_concrete = false;

show_foundation_concrete = false;

// Show roof: 0 = no, 1 = truss supports, 2=+furlings,
// 3=+transparent roof metal, 4 = +opaque roof metal.
show_roof = 2;

house_sz = [515, 410];
bedroom_l = 290;
front_cut_diag = 70;
toilet_cut_d = [170, 139];

wall_thickness = 11;
wall_height = 265;

floor_thickness = 10;

c_bar_height = 3 * 2.54;
roof_angle = 20;


module guestroom()
{
    if (show_furniture) {
        furniture();
    }
    
    if (show_roof > 0.5) {
        truss_pos = [-1, 
            (house_sz[0] - bedroom_l - wall_thickness-3)/2,
            house_sz[0] - bedroom_l - wall_thickness,
            house_sz[0] - toilet_cut_d[0] + 1,
            house_sz[0]];
        translate([0, house_sz[1]/2, wall_height -
            0*c_bar_height * cos(roof_angle)])
        rotate([0,0,90])
        roof(house_sz[0], house_sz[1], toilet_cut_d, truss_pos, 5, show_roof);
    }
        
    floor(house_sz, front_cut_diag, toilet_cut_d,
        floor_thickness, transparent_concrete);

    foundation(house_sz, front_cut_diag, toilet_cut_d, 
        bedroom_l, wall_thickness, wall_height, 11,
        roof_angle, show_foundation_concrete);
    
    plumbing(house_sz, front_cut_diag, toilet_cut_d, 
        bedroom_l, wall_thickness, wall_height, 11,
        roof_angle, show_foundation_concrete);
    
    walls(house_sz, front_cut_diag, toilet_cut_d, 
        bedroom_l, wall_thickness, wall_height, 11,
        roof_angle, transparent_concrete);
}
    
module furniture()
{
    // Table
    table_h = 75;
    translate([70,195, table_h/2]) 
        color([63/255,31/255,15/255,1]) 
        cube([120,70,table_h], center=true);
    
    // Chairs
    translate([105,130, 0]) chair();
    translate([50,130, 0]) chair();
    translate([50,260, 0]) rotate([0,0,180]) chair();
    translate([105,260, 0]) rotate([0,0,180]) chair();
    
    sala_w = house_sz[0] - bedroom_l - 2.5 * wall_thickness;
    
    // Fridge
    fridge_w = 55;
    fridge_d = 57;
    fridge_h = 146;
    translate([wall_thickness+sala_w-fridge_w/2-2,house_sz[1] - wall_thickness - fridge_d/2, fridge_h/2]) 
        color("Wheat")
        cube([fridge_w,fridge_d,fridge_h], center=true);
        
    // Sink and cooking table
    sinktab_w = sala_w-fridge_w-5;
    sinktab_d = 60;
    sinktab_h = 75;
    tile_t = 1;
    translate([wall_thickness+sinktab_w/2,
        house_sz[1] - wall_thickness - sinktab_d/2, 
        sinktab_h/2]) 
    {
        color("MediumSeaGreen") 
        cube([sinktab_w,sinktab_d,sinktab_h], center=true);
        translate([0,0,sinktab_h/2+tile_t/2])
        color("black") cube([sinktab_w+0.1,sinktab_d+0.1,tile_t+0.1], center=true);
    }
    
    // Kitchen cupboard
    cupboard_w =  sinktab_w;
    cupboard_d = 30;
    cupboard_h = 60;
    translate([wall_thickness+cupboard_w/2,
        house_sz[1] - wall_thickness - cupboard_d/2, 
        cupboard_h/2+120]) 
        color("MediumSeaGreen") 
        cube([cupboard_w,cupboard_d,cupboard_h], center=true);
        
    
    // Bed
    bed_h = 45;
    translate([417,285, bed_h/2]) 
    color("Aquamarine") 
    cube([150, 200,bed_h], center=true);
    
    // Cabinet for clothes
    cabinet_w = 130;
    cabinet_d = 45;
    cabinet_h = 220;
    translate([2*wall_thickness+sala_w+cabinet_d/2+3,house_sz[1] - wall_thickness - cabinet_w/2-3, cabinet_h/2]) 
        color("MediumSeaGreen")
        cube([cabinet_d,cabinet_w,cabinet_h], center=true);
      
    // Toilet seat
    translate([house_sz[0] - toilet_cut_d[0] - 48, toilet_cut_d[1]-1, 0])
    toiletseat();
    //translate([house_sz[0] - toilet_cut_d[0] - wall_thickness, wall_thickness, 60])
    translate([house_sz[0] - bedroom_l - 0.5*wall_thickness, toilet_cut_d[1]-10, 60])
    rotate([0,0,-90])
    bathroomsink();
}        

module chair()
{
    chair_w = 43;
    chair_d = 44;
    chair_h = 43;
    chair_back_h = 77;
    chair_back_t = 5;
    
    translate([0,0, chair_h/2])
    color("Peru") {
        cube([chair_w,chair_d,chair_h], center=true);
    
        translate([0,-(chair_d-chair_back_t)/2,
            chair_h/2+chair_back_h/2+2])
        cube([chair_w,chair_back_t,chair_back_h], center=true);
    }
}
guestroom();