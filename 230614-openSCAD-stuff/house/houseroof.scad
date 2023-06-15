module houseroof(width=800, length=1200) {
beam_height = 9;
beam_width = 4.5;  
roof_angle = 15;
front_lip = 150;
back_lip = 150;
side_lip = 150;
air_gap = 30;
    
beam_length = length + front_lip + back_lip;

for (pos = [-width/2-side_lip:20:-80 /* width/2 */]) {
  translate([(front_lip-back_lip)/2, pos, (pos+width/2)*tan(roof_angle)+air_gap]) rotate([roof_angle,0, 0]) cube([beam_length,beam_width,beam_height],center=true);
}

for (pos = [-120/*-width/2*/:20:width/2+side_lip]) {
  translate([(front_lip-back_lip)/2, pos, (pos-width/2)*tan(-roof_angle)+air_gap]) rotate([-roof_angle,0, 0]) cube([beam_length,beam_width,beam_height],center=true);
}
}

houseroof();