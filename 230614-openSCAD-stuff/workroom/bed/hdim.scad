module hdim(x1 = 10, x2 = 20, y = 10, dimline_lenght = 9.0) 
{
    dimline_overlap = 0.5;
    dimline_width = 0.3;
    text_size = 2;
    
    // rotate([0,90,rotation]) 
    color([0,0,0])
    // translate([0,0,hex_length*0.5]) 
    {
        translate([x1,y-dimline_lenght/2,0]) 
            square([dimline_width, 
                dimline_lenght + 2*dimline_overlap], 
                center=true, $fs=0.01);
                
        translate([x2,y-dimline_lenght/2,0]) 
            square([dimline_width, 
                dimline_lenght + 2*dimline_overlap], 
                center=true, $fs=0.01);

        translate([(x1+x2)/2,y-dimline_lenght,0]) 
            square([x2-x1, 
                dimline_width], 
                center=true, $fs=0.01);
        
        translate([(x1+x2)/2,y-dimline_lenght-dimline_overlap-text_size/2,0]) 
            text(str(x2-x1), size = text_size, 
                halign = "center",valign = "center");
    }
}

hdim();