module worktable(width = 330, depth = 65.5, height = 79)
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
        text("WORK TABLE", size = text_size, 
            halign = "left",valign = "top");

    } 
}        

worktable();