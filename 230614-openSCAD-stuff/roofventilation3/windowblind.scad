use <Lprofile.scad>

module windowblind(height=60, width=50, lprofile_width=2.54, lprofile_thickness=0.3,explode=false) 
{
    playwood_thickness = 0.75*2.54;
    plawood_allowance = 0.2;
    playwood_width = width - 2.0 * (lprofile_thickness + plawood_allowance);
    playwood_height = height - 2.0 * (lprofile_thickness + plawood_allowance);
    explo_dist = explode ? 8 : 0;
    
    translate([0,0,-explo_dist])
    lprofile(width, lprofile_width, lprofile_thickness, true) ;

    translate([0,0,height+explo_dist])
    rotate([180,0,180])
    lprofile(width, lprofile_width, lprofile_thickness, true) ;

    translate([width/2+explo_dist,0,height/2])
    rotate([0,270,0])
    lprofile(height, lprofile_width, lprofile_thickness, true) ;
    
    translate([-width/2-explo_dist,0,height/2])
    rotate([0,90,0])
    lprofile(height, lprofile_width, lprofile_thickness, true) ;

    color([0.8, 0.8, 0.0])
    translate([0,lprofile_thickness+playwood_thickness/2,height/2])
    cube([playwood_width, playwood_thickness, playwood_height], center = true);
}

windowblind();