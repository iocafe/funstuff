module simpleplaywood(length=57, width = 210, spacing = 0.5, playwood_thickness = 0.75 * 2.54, c = [0.80,0.43,0.32]) 
{
    translate([length/2+spacing,width/2+spacing,-playwood_thickness/2])
    color(c)
    cube([length-2*spacing, width-2*spacing, playwood_thickness],center=true);
    
 
}

simpleplaywood();