color("pink") {
translate([10,0,30]) cube([10,10,60],center=true);
translate([-10,0,30]) cube([10,10,60], center=true);
translate([-0,0,80]) cube([35,15,40], center=true);
translate([0,0,115])  cube([25,25,25],  center=true);
translate([40,0,95]) cube([50,10,10], center=true);
translate([-40,0,95]) cube([50,10,10], center=true);
}

color("black") {
translate([8,-10,118]) rotate([90,0,0]) cylinder(h=11,d=8,center=true);
translate([-8,-10,118]) rotate([90,0,0]) cylinder(h=11,d=8,center=true);
}