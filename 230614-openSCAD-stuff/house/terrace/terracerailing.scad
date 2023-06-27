module terracerailing(width=300, length=800, railing_thickness=15, railing_height=260) 
{
    translate([0,width/2-railing_thickness/2, railing_height/2]) cube([length, railing_thickness, railing_height],center=true);
        
    /* translate([0,-width/2+railing_thickness/2, railing_height/2]) cube([length, railing_thickness, railing_height],center=true); */
    
    translate([length/2-railing_thickness/2, 0, railing_height/2]) cube([railing_thickness, width, railing_height],center=true);
    
    /* translate([-length/2+railing_thickness/2, 0, railing_height/2]) cube([railing_thickness, width, railing_height],center=true); */
}

terracerailing();