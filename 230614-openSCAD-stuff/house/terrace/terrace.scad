 use <terracerailing.scad>

module terrace(width=340, length=1000, railing_thickness=15, railing_height=100,railing_color=[255/255, 255/255, 255/255],railing_alpha=1.0) 
{
    color (railing_color,railing_alpha)
    terracerailing(width, length, railing_thickness, railing_height);
}

// For testing
terrace();