module laundrytable(width = 330, depth = 65.5, height = 79)
{
    text_size = 5;
    row_step = 7;
    xmargin = 2;
    ystart = width - row_step;
    color([0.8,0.8,0.8, 0.6]) 
    cube([depth, width, height], center = false);
    
    color([0.5,0.5,0.1,1.0])
    {
        translate([xmargin,ystart,height]) 
        text("FRONT SHELF", size = text_size, 
            halign = "left",valign = "top");

        translate([xmargin,ystart-1*row_step,height]) 
        text("262 cm coco [1]", size = text_size, 
            halign = "left",valign = "top");

        translate([xmargin,ystart-2*row_step,height]) 
        text("202 cm coco [3]", size = text_size, 
            halign = "left",valign = "top");

        translate([xmargin,ystart-3*row_step,height]) 
        text("158.5 cm coco [1]", size = text_size, 
            halign = "left",valign = "top");

        translate([xmargin,ystart-4*row_step,height]) 
        text("115.5 cm coco [1]", size = text_size, 
            halign = "left",valign = "top");

        translate([xmargin,ystart-5*row_step,height]) 
        text("64 cm coco [2]", size = text_size, 
            halign = "left",valign = "top");
            
        translate([xmargin,ystart-6*row_step,height]) 
        text("62 cm coco [2]", size = text_size, 
            halign = "left",valign = "top");

        ystart2 = ystart-8*row_step;
        translate([xmargin,ystart2,height]) 
        text("DIVIDER SHELF", size = text_size, 
            halign = "left",valign = "top");
            
        translate([xmargin,ystart2-1*row_step,height]) 
        text("292.7 cm coco [2]", size = text_size, 
            halign = "left",valign = "top");
            
        translate([xmargin,ystart2-2*row_step,height]) 
        text("261 cm coco [2]", size = text_size, 
            halign = "left",valign = "top");
            
        translate([xmargin,ystart2-3*row_step,height]) 
        text("125 cm coco [3]", size = text_size, 
            halign = "left",valign = "top");
            
        ystart3 = ystart2-5*row_step;
        translate([xmargin,ystart3,height]) 
        text("BED", size = text_size, 
            halign = "left",valign = "top");
            
        translate([xmargin,ystart3-1*row_step,height]) 
        text("94 cm coco [5]", size = text_size, 
            halign = "left",valign = "top");
            
        translate([xmargin,ystart3-2*row_step,height]) 
        text("199.3 cm coco [2]", size = text_size, 
            halign = "left",valign = "top");

        translate([xmargin,ystart3-3*row_step,height]) 
        text("25.7 cm coco [2]", size = text_size, 
            halign = "left",valign = "top");
    } 
}        

laundrytable();