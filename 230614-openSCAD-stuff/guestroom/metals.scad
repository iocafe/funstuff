module anglebar(length=100, c = "DimGray", width=1.5*2.54, thickn=0.4) 
{
    color(c) {
        translate([0,width/2,thickn/2]) 
            cube([length, width, thickn], center = true);
        translate([0,thickn/2,width/2]) 
            cube([length, thickn, width], center = true);
    }
}

module anglebar1(length=100, c = "DimGray", thickn=0.3)
{
    anglebar(length, c, 2.54, thickn);
}

module anglebar15(length=100, c = "DimGray", thickn=0.4)
{
    anglebar(length, c, 1.5*2.54, thickn);
}

module anglebar2(length=100, c = "DimGray", thickn=0.5)
{
    anglebar(length, c, 2*2.54, thickn);
}

module c_bar(length=100, c = "DarkGray", width=1.5*2.54, height = 3*2.54,thickn=0.6) 
{
    color(c) {
        translate([0,width/2,-height/2+thickn/2]) 
            cube([length, width, thickn], center = true);
        translate([0,thickn/2,0]) 
            cube([length, thickn, height], center = true);
        translate([0, width/2,height/2 - thickn/2]) 
            cube([length, width, thickn], center = true);
    }
}

module c_bar3(length=100, c = "DarkGray", thickn=0.6) 
{
    c_bar(length, c, 1.5*2.54, 3*2.54,thickn);
} 

module c_furling(length=100, c = "DarkGray", width=1.5*2.54, height = 3*2.54,thickn=0.2) 
{
    elbow = height/10;
    color(c) {
        translate([0,width/2,-height/2+thickn/2]) 
            cube([length, width, thickn], center = true);
        translate([0,thickn/2,0]) 
            cube([length, thickn, height], center = true);
        translate([0, width/2,height/2 - thickn/2]) 
            cube([length, width, thickn], center = true);

        translate([0,width-thickn/2,-height/2+elbow/2]) 
            cube([length, thickn, elbow], center = true);

        translate([0,width-thickn/2,height/2-elbow/2]) 
            cube([length, thickn, elbow], center = true);
    }
}

module c_furling3(length=100, c = "DarkGray", thickn=0.2) 
{
    c_furling(length, c, 1.5*2.54, 3*2.54,thickn); 
}

module roof_turn(length=100, bend_r = 2, alpha=25, thickn=0.06) 
{
    move_y = bend_r * sin(alpha);
   
    rotate([90,0,0])
    difference() {
        translate([0,-move_y,0]) 
        cylinder(h = length, r = bend_r, $fn=16);
        
        translate([0,-move_y,-0.5]) 
        cylinder(h = length+1, r = bend_r-thickn, $fn=16);
        
        cube_sz = 2*bend_r + 0.2;
        translate([0,-cube_sz/2-0.05,length/2]) 
        cube([cube_sz, cube_sz, length + 0.5], center = true);
    }
}

module roof_slice(length=100, r = 2,alpha=20, thickn=0.06) 
{
    bend_r = r/cos(alpha);
    move_y = bend_r * (1-sin(alpha));
    
    translate([-r, 0, move_y]) 
       roof_turn(length, bend_r, alpha, thickn); 

    translate([r, 0, move_y]) 
    rotate([0,180,0])
       roof_turn(length, bend_r, alpha, thickn); 
}

module roof_piece(length=300, width=105, c = "green") 
{
    r = 3*2.54/4;
    alpha = 45;
    n = ceil(width/(4*r));
    color(c)
    intersection() {
        union() {
            for (i = [0:n-1]) {
                x = i * 4 * r;
                translate([x-width/2,length,0])
                roof_slice(length, r, alpha);
            }
        }
        
        cube_h = 2*r;
        translate([0,length/2,cube_h/2]) 
        cube([width, length, cube_h], center = true);
    }
}

roof_piece();