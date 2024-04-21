module roof(box_length=140, box_width=90, overlap=100, roof_angle=20, metal_thickness = 1, explode=true) 
{
    length = box_length + 2 * overlap;
    width = box_width + 2 * overlap;
    straight_top = box_length-box_width;
    diam = 4;
    
    expl_d = explode ? 50 : 0;

    translate([0,expl_d,0])
    roofpiece2(length, straight_top, width/2, roof_angle, metal_thickness, diam,    explode);
   
    translate([-straight_top/2-expl_d,0,0])
    rotate([0,0,90]) 
    roofpiece2(width, 0, width/2, roof_angle, metal_thickness, diam, explode);

    translate([0,-expl_d,0])
    rotate([0,0,180]) 
    roofpiece2(length, straight_top, width/2, roof_angle, metal_thickness, diam, explode);

    translate([straight_top/2+expl_d,0,0])
    rotate([0,0,270]) 
    roofpiece2(width, 0, width/2, roof_angle, metal_thickness, diam, explode);
}

module roofpiece(bottom_d, top_d, width, roof_angle, metal_thickness, explode) 
{
    roofing_w = width / cos(roof_angle);
    expl_d = explode ? 200 : 0;

    color([0,0.9,0.9,0.6])
    rotate([-roof_angle,0,0])
    translate([0,0,expl_d])
    linear_extrude(metal_thickness) 
    polygon(points=[[-top_d/2,0],[top_d/2,0],[bottom_d/2,roofing_w], [-bottom_d/2,roofing_w],[-top_d/2,0]]);
}

module roofpiece2(bottom_d, top_d, width, roof_angle, metal_thickness, diam, explode) 
{
    roofpiece(bottom_d, top_d, width, roof_angle, metal_thickness, explode);

    roofing_w = width / cos(roof_angle);
    expl_d = explode ? 35 : 0;
  
    use_w = roofing_w - 2.5 * diam;
    n = 4;
    angle = atan2(bottom_d-top_d, 2*roofing_w);
    th = diam / sin(angle);
    
    for (p = [0:n]) {
        pos = p * use_w / n + diam;
        w = 2*pos * tan(angle) + top_d - 2*th - 2*diam; 
        if (w > 0) {
        rotate([-roof_angle,0,0])
        translate([0, pos+expl_d, expl_d])
        roofsupport2(w, diam, angle, angle); 
        }
    }
    
    mv = ((top_d > 0.01) ? 1.5 : 3.0);
    mv2 = ((top_d > 0.01) ? 0 : -1.8);
    mv3 = ((top_d > 0.01) ? 0 : 0.9);
    
    use_w2 = roofing_w - mv * diam;
    di = bottom_d - top_d - mv * diam;
    edge = sqrt(use_w2*use_w2 + 0.25*di * di);
    rotate([-roof_angle,0,0])
    translate([0.25*(top_d+bottom_d)-1.7*diam-mv2, 0.5*roofing_w-0.15*diam+mv3, 0])
    rotate([0,0,90-angle])
    roofsupport2(edge, diam, (top_d > 0.01) ? angle : -angle, -angle); 

    rotate([-roof_angle,0,0])
    translate([-0.25*(top_d+bottom_d)+1.7*diam+mv2, 0.5*roofing_w-0.15*diam+mv3, 0])
    rotate([0,0,90+angle])
    roofsupport2(edge, diam, (top_d > 0.01) ? -angle : angle, angle); 
    
    playwood_thickness = 0.75 * 2.54;
    playsupport(bottom_d, top_d, width, roof_angle, playwood_thickness, diam, true, explode); 

    playsupport(bottom_d, top_d, width, roof_angle, playwood_thickness, diam, false,explode); 

    metalcorners(bottom_d, top_d, width, roof_angle, metal_thickness, true,explode); 
    
    metalcorners(bottom_d, top_d, width, roof_angle, metal_thickness, false,explode); 
    
}



module roofsupport2(length, diam, angle1, angle2) 
{
    cut_diam1 = diam * tan(angle1);
    cut_diam2 = diam * tan(angle2);

    color([0.9,0.4,0.9])
    translate([0,0,-diam])
    linear_extrude(diam) 
    polygon(points=[
        [-length/2+cut_diam1/2, -diam/2],
        [length/2-cut_diam2/2, -diam/2],
        [length/2+cut_diam2/2, diam/2],
        [-length/2-cut_diam1/2,diam/2],
        [-length/2+cut_diam1/2,-diam/2]]);
}

module playsupport(bottom_d, top_d, width, roof_angle, playwood_thickness, diam, isleft, explode) 
{
    roofing_w = width / cos(roof_angle);
    expl_d = explode ? (isleft ? 150 : -150) : 0;
    expl_d2 = explode ? (isleft ? 10 : -10) : 0;
    play_width = 14 * sqrt(2);
    spacing = 3.5;
    
    translate ([expl_d2,0,(isleft ? -playwood_thickness : 0) - diam - 0.4]) {
        color([0.7,1.0,0.7,0.7])
        rotate([-roof_angle,0,0])
        rotate([0, isleft ? 0 : 180,0])
        translate([0,0,expl_d])
        linear_extrude(playwood_thickness) 
        if (top_d>0.01) {
            polygon(points=[[top_d/2-play_width-spacing,0],[top_d/2-spacing,0],[bottom_d/2-3*spacing,roofing_w-2*spacing], [bottom_d/2-3*spacing-play_width,roofing_w-2*spacing],[top_d/2-play_width-spacing,0]]);
        }
        else {
            polygon(points=[[0,spacing],[0,play_width+spacing],[bottom_d/2-play_width-2*spacing, roofing_w-2*spacing],[bottom_d/2-2*spacing,roofing_w-2*spacing],[0,spacing]]);
        }
    }
}

module metalcorners(bottom_d, top_d, width, roof_angle, metal_thickness, isleft, explode) 
{
    roofing_w = width / cos(roof_angle);
    expl_d = explode ? (isleft ? 240 : -240) : 0;
    expl_d2 = explode ? (isleft ? 132 : -132) : 0;
    play_width = 15 * sqrt(2);
    
    translate ([expl_d2,0,isleft ? 2*metal_thickness : 3*metal_thickness]) {
        color([0.7,0.7,0.7,0.5])
        rotate([-roof_angle,0,0])
        rotate([0, isleft ? 0 : 180,0])
        translate([0,0,expl_d])
        linear_extrude(metal_thickness) 
        if (top_d>0.01) {
            polygon(points=[[top_d/2-play_width,0],[top_d/2,0],[bottom_d/2,roofing_w], [bottom_d/2-play_width,roofing_w],[top_d/2-play_width,0]]);
        }
        else {
            polygon(points=[[0,0],[0,play_width],[bottom_d/2-play_width, roofing_w],[bottom_d/2,roofing_w],[0,0]]);
        }
    }
}

roof();
