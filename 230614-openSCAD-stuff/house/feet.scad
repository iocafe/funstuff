
use <foot.scad> 

module feet(house_width=1200, house_length=800, feet_height=200, extend_up=100) {

feet_thickness = 30;
feet_indent = 5;

foot([-house_length/2+feet_thickness/2+feet_indent,house_width/2-feet_thickness/2-feet_indent,0], feet_thickness, feet_height,extend_up);

foot([house_length/2-feet_thickness/2-feet_indent,house_width/2-feet_thickness/2-feet_indent,0], feet_thickness, feet_height,extend_up);

foot([-house_length/2+feet_thickness/2+feet_indent,-house_width/2+feet_thickness/2+feet_indent,0], feet_thickness, feet_height,extend_up);

foot([house_length/2-feet_thickness/2-feet_indent,-house_width/2+feet_thickness/2+feet_indent,0], feet_thickness, feet_height,extend_up);
}

// feet(1230,500);
