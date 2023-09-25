module bedleg(cw_w = 5.08, cw_h = 15.24, mirror = true, leglength=28) 
{
    if (mirror) 
    {
        translate([-cw_w,0,-leglength]) color([0.40,0.30,0.16,1.0])
            cube([cw_w, cw_h, leglength],center=false);
        
        translate([-cw_w-cw_h,0,-leglength]) color([0.51,0.38,0.24,1.0])
            cube([cw_h, cw_w, leglength],center=false);
    }
    else {
        translate([0,0,-leglength]) color([0.40,0.30,0.16,1.0])
            cube([cw_w, cw_h, leglength],center=false);
        
        translate([cw_w,0,-leglength]) color([0.51,0.38,0.24,1.0])
            cube([cw_h, cw_w, leglength],center=false);
    }
}

bedleg();