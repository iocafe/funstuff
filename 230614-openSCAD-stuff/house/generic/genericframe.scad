module genericframe(width = 40, height = 80, frame_width = 2, frame_depth = 4)
{
    translate([width/2-frame_width/2,0,0]) cube([frame_width,4,height], center=true);
    translate([-width/2+frame_width/2,0,0]) cube([frame_width,4,height], center=true);
    translate([0,0,height/2-frame_width/2]) rotate([0,90,0]) cube([frame_width,frame_depth,width], center=true);
    translate([0,0,-height/2+frame_width/2]) rotate([0,90,0]) cube([frame_width,frame_depth,width], center=true);
}

translate([60,0,0]) genericframe(30, 100);
translate([-60,0,0]) genericframe(50, 90);
