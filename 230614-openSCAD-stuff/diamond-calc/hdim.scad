module hdim(
  x1 = 10, 
  x2 = 200, 
  y = 10, 
  dimline_lenght = 9.0,
  scaling = 1.0) 
{
    dimline_overlap = scaling * 0.5;
    dimline_width = scaling * 0.6;
    text_size = scaling * 4;
    tmp = 2*dimline_overlap+text_size/2;
    scaled_dl_len = scaling * dimline_lenght;
    text_pos = scaled_dl_len>0 ? tmp : -tmp; 
    dimline_abs = scaled_dl_len>0 ? scaled_dl_len : -scaled_dl_len;
    
    color([146/255, 154/255, 255/255, 0.7])
    {
        translate([x1,y-scaled_dl_len/2,0]) 
            cube([dimline_width, 
                dimline_abs + 2*dimline_overlap,
                dimline_width/2], 
                center=true);
                
        translate([x2,y-scaled_dl_len/2,0]) 
            cube([dimline_width, 
                dimline_abs + 2*dimline_overlap,
                dimline_width/2], 
                center=true);

        translate([(x1+x2)/2,y-scaled_dl_len,0]) 
            cube([x2-x1, 
                dimline_width,
                dimline_width/2], 
                center=true);
    }
        
    translate([(x1+x2)/2,y-scaled_dl_len-text_pos,0]) 
    {
        color([106/255, 134/255, 245/255])
        cube([text_size * 5, 1.2*text_size, 0.8*scaling], center=true);
        
        color([1,1,1,1])
        {
            translate([0,0,0.4*scaling])
            linear_extrude(0.2*scaling)
            text(str(0.1*round((x2-x1)*10)), size = text_size, 
                halign = "center",valign = "center");
            translate([0,0,-0.4*scaling])
            rotate([0,180,0])
            linear_extrude(0.2*scaling)
            text(str(0.1*round((x2-x1)*10)), size = text_size, 
                halign = "center",valign = "center");
        }
    }
}

hdim();