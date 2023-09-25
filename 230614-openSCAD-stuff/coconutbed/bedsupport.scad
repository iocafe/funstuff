use <bedleg.scad> 
extra_leg_spacing = 1.5;

module bedsupport(matress_length=190, matress_width = 152.4, cw_w = 5.08, cw_h = 15.24, jw_w=4.80, jw_h = 4.8, groove_depth = 1.5) 
{
    translate([0,0,-cw_h/2+cw_w-groove_depth+cw_w/2])
    {
        color([0.71,0.40,0.11])
            cube([cw_h, matress_width, cw_w],center=true);
    
        translate([0,0,cw_w/2]) 
            rotate([0,0,90])
            color([1,1,1])
            text(str(matress_width," cm"), size = 7, halign = "center",valign = "center");
    }
}

bedsupport();