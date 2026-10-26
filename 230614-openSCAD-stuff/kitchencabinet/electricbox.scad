width_from_pillar = 90;
left_edge_from_wall = 96;
depth_from_tile = 26;
front_edge_from_wall = 28;
height = 62.5;

module electric_box()
{
    color([0.6,0.6,0.6,0.5]) 
    translate([-left_edge_from_wall,-depth_from_tile,-height]) 
    {
        color("green")
            cube ([width_from_pillar, 
                depth_from_tile, height], 
                    center = false);
    }
}

electric_box();
