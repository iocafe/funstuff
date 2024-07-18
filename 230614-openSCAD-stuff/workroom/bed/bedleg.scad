module bedleg(cw_w = 5.08, cw_h = 15.24, mirror = true, leglength=25.7,leg_angle=0) 
{
    translate([-cw_w/2,0, -2*cw_w/2]) 
    rotate([0,leg_angle,0])
    translate([cw_w/2,0, 2*cw_w/2]) 
    {
        if (mirror) 
        {
            translate([-cw_w,0,-leglength]) 
                oneleg(cw_w, cw_h, leglength);
        }
        else {
            translate([0,0,-leglength])
                oneleg(cw_w, cw_h, leglength);

        }
    }
}

module oneleg(cw_w = 5.08, cw_h = 15.24, leglength=25.7)
{
    indent_w = 5;
    indent_h = cw_w + 3;
    top_z = 3;
    
    color([0.40,0.30,0.16,1.0])
    translate([cw_w,0,leglength])
    rotate([-90,0,90])
    linear_extrude(cw_w)
    polygon(points=[[0,top_z],[cw_h-indent_w,top_z],[cw_h-indent_w, indent_h],[cw_h, indent_h],[cw_h, leglength],[0,leglength]]); //,[0,indent_h], [indent_w,indent_h]]);

    color([0.8,0.8,0.5,1.0])
    {
        translate([0,cw_h/2,0]) 
        rotate([90,90,-90])
        text(str(0.1 * round(10*(leglength-top_z))), size = 6, 
            halign = "right",valign = "center"); 
        translate([cw_w,cw_h/2,0]) 
        rotate([90,90,90])
        text(str(0.1 * round(10*(leglength-top_z))), size = 6, 
            halign = "right",valign = "center");
    }
}    

bedleg();