module hdim(x1 = 10, x2 = 20, y = 10, dimline_lenght = 9.0) 
{
    dimline_overlap = 0.5;
    dimline_width = 0.3;
    text_size = 2;
    tmp = 2*dimline_overlap+text_size/2;
    text_pos = dimline_lenght>0 ? tmp : -tmp; 
    dimline_abs = dimline_lenght>0 ? dimline_lenght : -dimline_lenght;
    
    color([0,0,0])
    {
        translate([x1,y-dimline_lenght/2,0]) 
            square([dimline_width, 
                dimline_abs + 2*dimline_overlap], 
                center=true, $fs=0.01);
                
        translate([x2,y-dimline_lenght/2,0]) 
            square([dimline_width, 
                dimline_abs + 2*dimline_overlap], 
                center=true, $fs=0.01);

        translate([(x1+x2)/2,y-dimline_lenght,0]) 
            square([x2-x1, 
                dimline_width], 
                center=true, $fs=0.01);
    }
        
    translate([(x1+x2)/2,y-dimline_lenght-text_pos,0]) 
    {
        color([0,0,0])
        cube([text_size * 5, 1.2*text_size, 0.9], center=true);
        
        color([0.8,0.8,0.5,1.0])
        {
            translate([0,0,0.2])
            text(str(0.1*round((x2-x1)*10)), size = text_size, 
                halign = "center",valign = "center");
            translate([0,0,-0.2])
            rotate([0,180,0])
            text(str(0.1*round((x2-x1)*10)), size = text_size, 
                halign = "center",valign = "center");
        }
    }
}

hdim();