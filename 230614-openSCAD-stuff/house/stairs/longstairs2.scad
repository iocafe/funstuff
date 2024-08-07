module longstairs2(length = 400, height = 260, width = 140, n_steps=14)
{
    beam_width = 15;
    stair_thickness = 8;
    wall_thickness = 15;
    
    x_step = length / n_steps;
    z_step = height / n_steps;
    extend_w = 6;
    extend_step = 5;
    balcony_size = 106;
    balcony_thickness = beam_width + stair_thickness;
    railing_height = 94;
    railing_bar_radius = 1.3;
    railing_pos = width/2 + 6;
    railing_w = 12;
    railing_thickness = 6;
    bar_railing_n = 6;
    
    stair_color=[230/255, 230/255, 230/255];
    side_color=[255/255, 255/255, 255/255];
    railing_bar_color = [0,0,0];
    railing_color = [0.3,0.1,0.1];
    stair_alpha = 1.0;
    
    union() {
            
        for (i = [0:n_steps-1])
        {
            x = x_step * i - length/2; 
            z = z_step * i;
            
            translate([x+0.5*x_step, width/2, z+0.5*z_step])
            color(side_color, stair_alpha)
            cube ([x_step, beam_width, z_step], center=true);
            
            translate([x+0.5*x_step, -width/2, z+0.5*z_step])
            color(side_color, stair_alpha)
            cube ([x_step, beam_width, z_step], center=true);
            
            if (i < bar_railing_n) {
                translate([x+0.5*x_step, railing_pos, z+1.5*z_step-stair_thickness])
                color(railing_bar_color)
                cylinder(h = railing_height, r = railing_bar_radius);
            }
            else {
                translate([x+0.5*x_step, railing_pos, (height + z)/2 +1.5*z_step-stair_thickness])
                color([1,1,1])
                cube([x_step, wall_thickness, height-z+10], center=true);
            }
            translate([x+0.5*x_step-extend_step/2, 
                +extend_w/2, 
                z+1.0*z_step + stair_thickness/2])
            color(stair_color, stair_alpha)
            cube ([x_step+extend_step, 
                width+beam_width+extend_w, 
                stair_thickness], center=true);
            
            if (i >= bar_railing_n) {
                translate([x+0.5*x_step, 
                    +extend_w/2, 
                    z+1.0*z_step - stair_thickness/2])
                color(stair_color, stair_alpha)
                cube ([x_step, 
                    width+beam_width+extend_w, 
                    z_step], center=true);
            }
        }
        
        dx = x_step * (n_steps-1);
        dz = z_step * (n_steps-1);
        l = sqrt(dx*dx + dz*dz);
        w = sqrt(x_step*x_step + z_step*z_step);
        
        translate([x_step/4, width/2, height/2 - z_step/4])
        rotate([0, -atan2(z_step, x_step), 0])
        color(side_color, stair_alpha)
        cube ([l, beam_width, w*0.5], center=true);
        
        translate([x_step/4, -width/2, height/2 - z_step/4])
        rotate([0, -atan2(z_step, x_step), 0])
        color(side_color, stair_alpha)
        cube ([l, beam_width, w*0.5], center=true);
        
        translate([(n_steps-1)*x_step/2+0.5*x_step + balcony_size/2,
            extend_w/2, 
            (n_steps-1)*z_step+2.0*z_step - balcony_thickness/2 + stair_thickness])
        color(side_color, stair_alpha)
        cube ([balcony_size, width+beam_width+extend_w, balcony_thickness], center=true);
        
        dx2 = x_step * (bar_railing_n+1);
        dz2 = z_step * (bar_railing_n+1);
        l2 = sqrt(dx2*dx2 + dz2*dz2);
        
        translate([-dx2/2, railing_pos, railing_height + dz2/2+1.5*railing_thickness])
        rotate([0, -atan2(z_step, x_step), 0])
        color(railing_color)
        cube ([l2, railing_w, railing_thickness], center=true);
    }
}

// For testing
longstairs2();