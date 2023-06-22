module cubewall(width=1200, length=800, wall_thickness=15, wall_height=260) 
{
    translate([0,width/2-wall_thickness/2, wall_height/2]) cube([length, wall_thickness, wall_height],center=true);
        
    translate([0,-width/2+wall_thickness/2, wall_height/2]) cube([length, wall_thickness, wall_height],center=true);
    
    translate([length/2-wall_thickness/2, 0, wall_height/2]) cube([wall_thickness, width, wall_height],center=true);
    
    translate([-length/2+wall_thickness/2, 0, wall_height/2]) cube([wall_thickness, width, wall_height],center=true);
}

cubewall();