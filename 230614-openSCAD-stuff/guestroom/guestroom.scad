use <floor.scad> 
use <walls.scad> 
use <roof/roof.scad>
use <toiletseat.scad>
use <bathroomsink.scad>

show_roof = true;
show_furniture = true;
transparent_concrete = false; // In walls and floor

bigger_house = false;
house_sz = bigger_house ? [595, 410] : [495, 410];
bedroom_l = bigger_house ? 310 : 240;
front_cut_diag = 70;
toilet_cut_d = bigger_house ? [165, 165] : [115, 145];

wall_thickness = 15;
wall_height = 260;

floor_thickness = 15;


module guestroom()
{
    if (show_furniture) {
        furniture();
    }
    
    if (show_roof) {
        truss_pos = [wall_thickness/2, 
            (house_sz[0] - bedroom_l - wall_thickness)/2,
            house_sz[0] - bedroom_l - wall_thickness,
            house_sz[0] - toilet_cut_d[0] - wall_thickness/2,
            house_sz[0] - wall_thickness/2];
        translate([0, house_sz[1]/2, wall_height])
        rotate([0,0,90])
        roof(house_sz[0], house_sz[1], truss_pos, 5);
    }
        
    floor(house_sz, front_cut_diag, toilet_cut_d,
        floor_thickness, transparent_concrete);
    
    walls(house_sz, front_cut_diag, toilet_cut_d, 
        bedroom_l, wall_thickness, wall_height,
        transparent_concrete);
    

}
    
module furniture()
{
    // Table
    table_h = 75;
    translate([70,195, table_h/2]) 
        color([63/255,31/255,15/255,1]) 
        // color("MediumSeaGreen")
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
        // color([73/255,113/255,178/255,1]) 
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
    translate([407,295, bed_h/2]) color("Aquamarine") cube([140,190,bed_h], center=true);
    
    // Cabinet for clothes
    cabinet_w = 130;
    cabinet_d = 35;
    cabinet_h = 220;
    translate([2*wall_thickness+sala_w+cabinet_d/2+2,house_sz[1] - wall_thickness - cabinet_w/2-1, cabinet_h/2]) 
        color("MediumSeaGreen")
        cube([cabinet_d,cabinet_w,cabinet_h], center=true);
      
    // Toilet seat
    translate([house_sz[0] - toilet_cut_d[0] - 48, 144, 0])
    toiletseat();
    translate([house_sz[0] - toilet_cut_d[0] - wall_thickness, wall_thickness, 60])
    rotate([0,0,90])
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