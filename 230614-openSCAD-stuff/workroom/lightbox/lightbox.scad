use <../hdim.scad> 


socket_base_diam = 10.3;
socket_base_height = 1.2;
socket_height = 4;
socket_neck_diam = 3.7;
socket_step = 11;

light_bulb_diam = 6;
light_bulb_center_pos = 4.5;
light_bulb_neck_diam = socket_neck_diam-0.4;
light_bulb_top_diam = light_bulb_neck_diam+0.6;

lid_bulp_hole_diam = socket_neck_diam + 0.6;

box_w = 15;
box_l = 48;
box_h = 6.6;
plywood_t = 1.9;

module lightbox(nro_light_bulps = 4)
{
    explode = false;
    edelta = explode ? 12 : 0;
    
    color([51/255, 34/255, 6/255, 0.9]) 
    translate([0,0,plywood_t/2])
    cube([box_l, box_w, plywood_t], center=true);

    socket_offs = -socket_step * (nro_light_bulps-1)/2;
    /* for (i = [0:nro_light_bulps-1])  
        echo(socket_step*i+socket_offs);
     */
    
    for (i = [0:nro_light_bulps-1])  
    {
        translate([socket_step*i+socket_offs, 0, plywood_t])
        socket();
    }
    
    translate([0,0, box_h-plywood_t/2+edelta])
    lid(nro_light_bulps, socket_step, socket_offs);

    color([71/255, 44/255, 16/255, 0.8]) {
        translate([-box_l/2+plywood_t/2-edelta,0,box_h/2])
        cube([plywood_t, box_w, box_h-2*plywood_t], center=true);
        translate([box_l/2-plywood_t/2+edelta,0,box_h/2])
        cube([plywood_t, box_w, box_h-2*plywood_t], center=true);
    }

    color([51/255, 44/255, 36/255, 0.9]) {
        translate([0,box_w/2-plywood_t/2+edelta,box_h/2])
        cube([box_l - 2*plywood_t, plywood_t, box_h-2*plywood_t], center=true);
        translate([0,-box_w/2+plywood_t/2-edelta,box_h/2])
        cube([box_l - 2*plywood_t, plywood_t, box_h-2*plywood_t], center=true);
    }
}        

module lid(nro_light_bulps = 4, socket_step = 11, socket_offs=-16.5)
{
    explode = false;

    color([51/255, 34/255, 6/255, 0.8]) 
    
    difference() {
        cube([box_l, box_w, plywood_t], center=true);

        for (i = [0:nro_light_bulps-1])  
        {
            translate([socket_step*i+socket_offs, 0, 0])
            cylinder(h = plywood_t + 0.5,
                d = lid_bulp_hole_diam, center=true, $fn = 25);
        }
    }
}

module socket()
{
    color([0.9, 0.9, 0.9, 1.0]) {
    cylinder(h = socket_base_height, d = socket_base_diam, $fn=25);
    cylinder(h = socket_height, d = socket_neck_diam, $fn=20);
    }
    
    color([0.8, 0.8, 0.6, 1.0])
    translate([0,0, socket_height])
    cylinder(h=light_bulb_center_pos, r2=light_bulb_top_diam/2, r1=light_bulb_neck_diam/2,center=false, $fn=20);
    
    translate([0,0, socket_height+light_bulb_center_pos])
    sphere(d = light_bulb_diam, $fn=25);
}

lightbox();