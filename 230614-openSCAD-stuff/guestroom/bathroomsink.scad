out_r1 = 30;
out_r2 = 32;
thickn = 2.5;
height = 10;

module bathroomsink() 
{
    $fn=40;
    color("LightSteelBlue") intersection() {
        union() {
            difference() {
                cylinder(r1 = out_r1, 
                    r2 = out_r2, h=height); 
                translate([0,0,thickn+0.1]) 
                cylinder(r1 = out_r1 - thickn, 
                    r2 = out_r2 - thickn, height); 
            }
    
           
            translate([0,0,height/2]) {
                cube([2 * out_r1, 2*thickn, height], center=true);
                cube([2*thickn, 2 * out_r1, height], center=true);
            }
        }
        translate([0,0,-1]) cube([out_r2, out_r2, 2*height]);
    }
}

bathroomsink();
