
use <foot.scad> 

module feet(house_width=800, house_length=1200, feet_height=200, extend_up=100) {

feet_thickness = 30;
feet_indent = -5;

foot([-house_length/2+feet_thickness/2+feet_indent,house_width/2-feet_thickness/2-feet_indent,0], feet_thickness, feet_height,extend_up);

foot([house_length/2-feet_thickness/2-feet_indent,house_width/2-feet_thickness/2-feet_indent,0], feet_thickness, feet_height,extend_up);

foot([-house_length/2+feet_thickness/2+feet_indent,-house_width/2+feet_thickness/2+feet_indent,0], feet_thickness, feet_height,extend_up);

foot([house_length/2-feet_thickness/2-feet_indent,-house_width/2+feet_thickness/2+feet_indent,0], feet_thickness, feet_height,extend_up);

foot([0,house_width/2-feet_thickness/2-feet_indent,0], feet_thickness, feet_height,extend_up);

foot([0,-house_width/2+feet_thickness/2+feet_indent,0], feet_thickness, feet_height,extend_up);

}

feet();
