module terraceroof(width=800, length=1200) {
beam_height = 9;
beam_width = 4.5;  
roof_angle = 15;
front_lip = 150;
back_lip = 150;
side_lip = 150;
air_gap = 0;
    
beam_length = length + front_lip + back_lip;

for (pos = [-width/2:50:width/2+side_lip]) {
  translate([(front_lip-back_lip)/2, pos, (pos-width/2)*tan(-roof_angle)+air_gap]) rotate([-roof_angle,0, 0]) cube([beam_length,beam_width,beam_height],center=true);
}

metal_thickness = 1;

translate([(front_lip-back_lip)/2, 0, (0-width/2)*tan(-roof_angle)+air_gap]) rotate([-roof_angle,0, 0]) translate([0,side_lip/2, 4.5]) cube([beam_length, (width+side_lip)/cos(roof_angle),metal_thickness],center=true);

}

terraceroof();