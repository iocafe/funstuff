module hdim(x1 = 10, x2 = 200, y = 10, dimline_lenght = 9.0) 
{
    dimline_overlap = 0.5;
    dimline_width = 0.4;
    text_size = 4;
    tmp = 2*dimline_overlap+text_size/2;
    text_pos = dimline_lenght>0 ? tmp : -tmp; 
    dimline_abs = dimline_lenght>0 ? dimline_lenght : -dimline_lenght;
    
    color([146/255, 154/255, 255/255, 0.7])
    {
        translate([x1,y-dimline_lenght/2,0]) 
            cube([dimline_width, 
                dimline_abs + 2*dimline_overlap,
                dimline_width/2], 
                center=true);
                
        translate([x2,y-dimline_lenght/2,0]) 
            cube([dimline_width, 
                dimline_abs + 2*dimline_overlap,
                dimline_width/2], 
                center=true);

        translate([(x1+x2)/2,y-dimline_lenght,0]) 
            cube([x2-x1, 
                dimline_width,
                dimline_width/2], 
                center=true);
    }
        
    translate([(x1+x2)/2,y-dimline_lenght-text_pos,0]) 
    {
        color([106/255, 134/255, 245/255])
        cube([text_size * 5, 1.2*text_size, 0.9], center=true);
        
        color([0,0,0,1])
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