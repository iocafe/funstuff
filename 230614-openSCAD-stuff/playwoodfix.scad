plywood_t = 0.5;
shoulder = 2.5;

module playwood_piece(length=30, width=20, thickness=plywood_t)
{
    rounded_end_d = 5;
    
    minkowski()
    {
        cube([length-rounded_end_d, width-rounded_end_d, 0.001], center = true);
        cylinder(d=rounded_end_d,h=thickness, center=true, $fn = 22);
    }
}

module playwood_plug(length=30, width=20, offs = 0)
{
    playwood_piece(length, width, plywood_t);
    translate([0,0,plywood_t+(offs>0?offs:0)])
    playwood_piece(length+2*shoulder, width+2*shoulder, plywood_t);
    
}

module ceiling(length=30, width=10)
{
    color([0.7,0.7,0.7,1.0]) difference() 
    {
        cube([50, 40, plywood_t], center = true);
        playwood_piece(length, width, 1.5*plywood_t);
    }
}


module demo(length=20, width=10)
{
    ceiling(length, width);
    pos = $t > 0.5 ? 15*(1-$t) : 0;
    translate([0,0,pos]) 
    playwood_plug(length, width, pos-5.8);
}

demo();