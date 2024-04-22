module vdim(y1 = 10, y2 = 20, x = 30, dimline_lenght = 9.0) 
{
    dimline_overlap = 0.5;
    dimline_width = 0.3;
    text_size = 2;
    
    rotate([90,0,0]) 
    color([0,0,0])
    {
        translate([x-dimline_lenght/2,y1,0]) 
            square([ 
                dimline_lenght + 2*dimline_overlap, dimline_width], 
                center=true, $fs=0.01);
                
        translate([x-dimline_lenght/2, y2,0]) 
            square([ 
                dimline_lenght + 2*dimline_overlap, dimline_width], 
                center=true, $fs=0.01);

        translate([x-dimline_lenght,(y1+y2)/2,0]) 
            square([ 
                dimline_width, y2-y1], 
                center=true, $fs=0.01);
        
        translate([x-dimline_lenght-text_size/2,(y1+y2)/2,0]) 
            text(str(y2-y1), size = text_size, 
                halign = "right",valign = "center");
    }
}

vdim();