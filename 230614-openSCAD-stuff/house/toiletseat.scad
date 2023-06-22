// toiletseat.scad, 22.6.2023/pekka
// Import toilet seat STL file toiletseat.stl 
// in "/coderoot/funstuff/230614-openSCAD-stuff/house/toiletseat.stl"
module toiletseat() 
{
    color([0.95,1.0, 0.95], 0.9) translate([-22,0,0]) rotate([90,0,0]) scale([0.07,0.07,0.07]) import("toiletseat.stl");
}

// translate([0,-42,0]) cube([36,1,100],center=true);
toiletseat();