ws = 12 * (1+sin(20*$t));

color("red") 
translate([0,0,0])
cube([50,20,10], center = true);

color("black") 
translate([3,0,10])
cube([30,20,10], center = true); 

translate ([15,10,-5])
rotate([90,0,0])
cylinder(h=3,d =ws , center=true);

translate ([-15,10,-5])
rotate([90,0,0])
cylinder(h=3,d =ws , center=true);

translate ([15,-10,-5])
rotate([90,0,0])
cylinder(h=3,d =ws , center=true);

translate ([-15,-10,-5])
rotate([90,0,0])
cylinder(h=3,d =ws , center=true);

