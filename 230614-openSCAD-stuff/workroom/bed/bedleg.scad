module bedleg(cw_w = 5.08, cw_h = 15.24, mirror = true, leglength=28) 
{
    if (mirror) 
    {
        translate([-cw_w,0,-leglength]) color([0.40,0.30,0.16,1.0])
            oneleg(cw_w, cw_h, leglength);
    }
    else {
        translate([0,0,-leglength]) color([0.40,0.30,0.16,1.0])
            oneleg(cw_w, cw_h, leglength);

    }
}

module oneleg(cw_w = 5.08, cw_h = 15.24, leglength=28)
{
    indent_w = 2;
    indent_h = cw_w + 1;
    //cube([cw_w, cw_h, leglength],center=false);
    
    translate([cw_w,0,leglength])
    rotate([-90,0,90])
    linear_extrude(cw_w)
    polygon(points=[[indent_w,0],[cw_h-indent_w,0],[cw_h-indent_w, indent_h],[cw_h, indent_h],[cw_h, leglength],[0,leglength],[0,indent_h], [indent_w,indent_h]]);
}    

bedleg();