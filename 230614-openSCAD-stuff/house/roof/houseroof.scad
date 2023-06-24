module houseroof(width=800, length=1200) {
beam_height = 9;
beam_width = 4.5;  
roof_angle = 15;
front_lip = 150;
back_lip = 150;
side_lip = 150;
air_gap = 30;
    
beam_length = length + front_lip + back_lip;
part_width = width/2+side_lip;
cross_over_1 = 80;
cross_over_2 = 120;
    
for (pos = [-part_width:50:-cross_over_1]) {
  translate([(front_lip-back_lip)/2, pos, (pos+width/2)*tan(roof_angle)+air_gap]) rotate([roof_angle,0, 0]) cube([beam_length,beam_width,beam_height],center=true);
} 

for (pos = [-cross_over_2:50:part_width]) {
  translate([(front_lip-back_lip)/2, pos, (pos-width/2)*tan(-roof_angle)+air_gap]) rotate([-roof_angle,0, 0]) cube([beam_length,beam_width,beam_height],center=true);
}

metal_thickness = 1;

translate([(front_lip-back_lip)/2, 0, (width/2)*tan(roof_angle)+air_gap]) rotate([roof_angle,0, 0]) translate([0,-side_lip-2.3*cross_over_1/1,4.5]) cube([beam_length,width/2+cross_over_1, metal_thickness],center=true);

translate([(front_lip-back_lip)/2, 0, (0-width/2)*tan(-roof_angle)+air_gap+4.5]) rotate([-roof_angle,0, 0]) translate([0,side_lip+cross_over_2/2,0]) cube([beam_length,part_width+cross_over_2, metal_thickness],center=true);
}

houseroof();