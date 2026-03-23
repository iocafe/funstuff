l = 20;
w = 10;
d = 1;
a = atan(w/l);
dy = d / sin(a);
dx = d / cos(a);

P = [[0, l/2], [w/2, 0], [w/2-dx, 0], [0, l/2-dy]];

module onepiece() 
{
    linear_extrude(height = d, center = true, convexity = 10)
    polygon(P, convexity = 3);
}

onepiece();
mirror([0,1,0]) onepiece();
mirror([1,0,0]) onepiece();
mirror([0,1,0]) mirror([1,0,0]) onepiece();