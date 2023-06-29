module longstairs(length = 400, height = 260, width = 140, n_steps=15)
{
    beam_width = 15;
    stair_thickness = 8;
    
    x_step = length / n_steps;
    z_step = height / n_steps;
    extend_w = 6;
    extend_step = 5;
    balcony_size = 140;
    balcony_thickness = beam_width + stair_thickness;
    railing_height = 100;
    railing_bar_radius = 1.3;
    railing_pos = -width/2 - 6;
    railing_w = 12;
    railing_thickness = 6;
    
    union() {
            
        for (i = [0:n_steps-1])
        {
            x = x_step * i - length/2; 
            z = z_step * i;
            
            translate([x+0.5*x_step, width/2, z+0.5*z_step])
            cube ([x_step, beam_width, z_step], center=true);
            
            translate([x+0.5*x_step, -width/2, z+0.5*z_step])
            cube ([x_step, beam_width, z_step], center=true);
            
            translate([x+0.5*x_step, railing_pos, z+1.5*z_step-stair_thickness])
            cylinder(h =railing_height, r = railing_bar_radius);
            
            translate([x+0.5*x_step-extend_step/2, 
                -extend_w/2, 
                z+1.0*z_step + stair_thickness/2])
            cube ([x_step+extend_step, 
                width+beam_width+extend_w, 
                stair_thickness], center=true);
        }
        
        dx = x_step * (n_steps-1);
        dz = z_step * (n_steps-1);
        l = sqrt(dx*dx + dz*dz);
        w = sqrt(x_step*x_step + z_step*z_step);
        
        translate([x_step/4, width/2, height/2 - z_step/4])
        rotate([0, -atan2(z_step, x_step), 0])
        cube ([l, beam_width, w*0.5], center=true);
        
        translate([x_step/4, -width/2, height/2 - z_step/4])
        rotate([0, -atan2(z_step, x_step), 0])
        cube ([l, beam_width, w*0.5], center=true);
        
        translate([(n_steps-1)*x_step/2+0.5*x_step + balcony_size/2, -extend_w/2, (n_steps-1)*z_step+1.0*z_step - balcony_thickness/2 + stair_thickness])
            cube ([balcony_size, width+beam_width+extend_w, balcony_thickness], center=true);
        
        for (x = [length/2  /*+ 0.5*x_step-extend_step/2 */:
             x_step:
             length/2 + balcony_size - x_step])
        {
            last_x = x+0.5*x_step;
            translate([last_x, railing_pos, height+0.5*z_step-stair_thickness])
            cylinder(h = railing_height, r = railing_bar_radius); 
        }
        
        for (z = [railing_pos + z_step: z_step: width/2])
        {
            translate([length/2+balcony_size, z, height+0.5*z_step-stair_thickness])
            cylinder(h = railing_height, r = railing_bar_radius);
        }
        
        dx2 = (x_step) * n_steps;
        dz2 = (z_step) * n_steps;
        l2 = sqrt(dx2*dx2 + dz2*dz2);
        //w = sqrt(x_step*x_step + z_step*z_step);
        
        translate([-x_step/2, railing_pos, railing_height + height/2])
        rotate([0, -atan2(z_step, x_step), 0])
        cube ([l2, railing_w, railing_thickness], center=true);
        
        translate([length/2+balcony_size/2, railing_pos, railing_height + height])
        cube ([balcony_size, railing_w, railing_thickness], center=true);
        
        translate([length/2+balcony_size, width/2+railing_pos+railing_w/3, railing_height + height])
    cube ([railing_w, width+x_step, railing_thickness], center=true);
    }
}

// For testing
longstairs();