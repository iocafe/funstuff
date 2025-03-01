use <floor.scad> 
use <walls.scad> 

house_sz = [495, 410];
front_cut_diag = 70;
toilet_cut_d = [115, 145];

pillar_d = 40;

wall_thickness=15;
bedroom_l = 240;

module chair()
{
    chair_w = 43;
    chair_d = 44;
    chair_h = 43;
    chair_back_h = 77;
    chair_back_t = 5;
    translate([0,0, chair_h/2])
        color("brown") {
        cube([chair_w,chair_d,chair_h], center=true);
        translate([0,-(chair_d-chair_back_t)/2,chair_h/2+chair_back_h/2+2])
            cube([chair_w,chair_back_t,chair_back_h], center=true);
        }
}

module guestroom()
{
    floor(house_sz, front_cut_diag, toilet_cut_d);
    
    walls(house_sz, front_cut_diag, toilet_cut_d, bedroom_l);
    
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
        color([73/255,113/255,178/255,1]) 
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
        color("brown") 
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
        color("brown") 
        cube([cupboard_w,cupboard_d,cupboard_h], center=true);
        
    
    // Bed
    bed_h = 35;
    translate([407,295, bed_h/2]) color("pink") cube([140,190,bed_h], center=true);
    
    // Cabinet for clothes
    cabinet_w = 130;
    cabinet_d = 35;
    cabinet_h = 220;
    translate([2*wall_thickness+sala_w+cabinet_d/2+2,house_sz[1] - wall_thickness - cabinet_w/2-1, cabinet_h/2]) 
        color("brown") 
        cube([cabinet_d,cabinet_w,cabinet_h], center=true);


}        

guestroom();