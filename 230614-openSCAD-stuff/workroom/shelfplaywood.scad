module shelfplaywood(width=60, height = 100, playwood_thickness = 0.75 * 2.54) 
{
    translate([0,playwood_thickness/2,height/2])
        
    color([214/255, 162/255, 29/255, 0.5])
    cube([width, playwood_thickness, height],center=true);
}

shelfplaywood();