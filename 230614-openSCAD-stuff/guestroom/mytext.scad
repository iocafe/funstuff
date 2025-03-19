module mytext(
  txt,
  n,
  w = 30,
  h = 50,
  sz = 4,
  scaling=1.0)
{
    color([106/255, 134/255, 245/255])
    cube([w*scaling, h*scaling, 0.5*scaling], center=true);
  
    color([1,1,1,1]) for (i = [0:n-1]) 
    {
      y = h*scaling/2 - 1.4 * (i+1) * sz * scaling;

      translate([0,y,0.25*scaling])
      linear_extrude(0.25*scaling)
      text(txt[i], size = sz, 
          halign = "center",valign = "center");

      translate([0,y,-0.25*scaling])
      rotate([0,180,0])
      linear_extrude(0.25*scaling)
      text(txt[i], size = sz, 
          halign = "center",valign = "center");
    }
}

mytext(["Pekka", "testaa", "tata"], 3);