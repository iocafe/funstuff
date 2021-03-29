# python3.8 -m pip install git+https://github.com/SolidCode/SolidPython.git
# python3.8 -m pip install skyfield
# python3.8 -m pip install viewscad (not used for now)
#
# sudo apt-get install openscad
#
# https://docs.astropy.org/en/latest/coordinates/index.html
# https://rhodesmill.org/skyfield/api-position.html

import numpy as np
import sys

import skyfield.api as sky

from solid import scad_render_to_file
from solid.objects import cube, cylinder, difference, translate, union, sphere
from solid.utils import right

# Gravitational constant m/s2
g = 6.674e-11

g = 3.674e-3

# XYZ history of celestial body
class history(object):
    def __init__(self):
        self.data=[]

    def record(self, X):
        self.data.append(X)

    def render_orbit(self):
        balls = union()
        for X in self.data:
            balls += translate((X[0], X[1], X[2]))(sphere(r=1.0))

        return balls

# Heavenly, or celestial, object
class celestial(object):
    def __init__(self, X=[0.0,0.0,0.0], V=[0.0,0.0,0.0], m=1.0):
        self.X=np.array(X) # position vector
        self.V=np.array(V) # speed vector
        self.A=np.array([0.0,0.0,0.0])
        self.m=m # object's mass
        self.history = history()

    def calc_A(self, sunandplanets, X):
        A = np.array([0.0,0.0,0.0])
        saved_m = self.m
        self.m = 0.0
        for p in sunandplanets.values():
            D = p.X - X
            r2 = np.sum(np.square(D))
            if r2 > 0.0:
                a = p.m / r2
                A = A + D * a / np.sqrt(r2)
        self.m = saved_m
        return A * g               

    def step(self, sunandplanets, dt=1.0):
        self.history.record(self.X)
        self.V = self.V + self.A * dt
        self.X = self.X + self.V * dt
        self.A = self.calc_A(sunandplanets, self.X)

    def render_orbit(self):
        return self.history.render_orbit()

# The solar system
class celestial_system(object):
    def __init__(self, name='earthsystem'):
        if name=='earthsystem':
            self.init_earth_system()

    def init_earth_system(self):
        self.sunandplanets = {}
        # self.sunandplanets['sun'] = celestial(m = 10000.0)
        # self.sunandplanets['earth'] = celestial(m = 1.0, X = [100.0, 0.0, 0.0], V = [0.0, 0.3, 0.3])
        self.sunandplanets['sun'] = celestial(m = 5000.0, X = [0.0, 0.01, 0.0], V = [-0.2, 0.0013, -0.1013])
        self.sunandplanets['earth'] = celestial(m = 1500.0, X = [100.0, 0.0, 0.0], V = [0.0, 0.2, 0.23])
        self.sunandplanets['moon'] = celestial(m = 50.0, X = [90.01, 0.02, 0.001], V = [0.0, 0.65, 0.65])

    def step(self, t=0, dt=1.0):
        for p in self.sunandplanets.values():
            p.step(self.sunandplanets, dt)

    def simulate(self, start_t=0.0, end_t=100.0, dt=1.0):
        for p in self.sunandplanets.values():
            p.A = p.calc_A(self.sunandplanets, p.X)
        for t in np.arange(start_t, end_t, dt):
            self.step(t, dt)

    def init_history(self):
        self.history = {}
        for name in self.sunandplanets:
            self.history[name] = ()

    def render_orbits(self):
        orbits = union()
        for p in self.sunandplanets.values():
            orbits += p.render_orbit()
        return orbits

def deg2HMS(ra='', dec='', round=False):
  RA, DEC, rs, ds = '', '', '', ''
  if dec:
    if str(dec)[0] == '-':
      ds, dec = '-', abs(dec)
    deg = int(dec)
    decM = abs(int((dec-deg)*60))
    if round:
      decS = int((abs((dec-deg)*60)-decM)*60)
    else:
      decS = (abs((dec-deg)*60)-decM)*60
    DEC = '{0}{1} {2} {3}'.format(ds, deg, decM, decS)
  
  if ra:
    if str(ra)[0] == '-':
      rs, ra = '-', abs(ra)
    raH = int(ra/15)
    raM = int(((ra/15)-raH)*60)
    if round:
      raS = int(((((ra/15)-raH)*60)-raM)*60)
    else:
      raS = ((((ra/15)-raH)*60)-raM)*60
    RA = '{0}{1} {2} {3}'.format(rs, raH, raM, raS)
  
  if ra and dec:
    return (RA, DEC)
  else:
    return RA or DEC

def HMS2deg(ra='', dec=''):
  RA, DEC, rs, ds = '', '', 1, 1
  if dec:
    D, M, S = [float(i) for i in dec.split()]
    if str(D)[0] == '-':
      ds, D = -1, abs(D)
    deg = D + (M/60) + (S/3600)
    DEC = '{0}'.format(deg*ds)
  
  if ra:
    H, M, S = [float(i) for i in ra.split()]
    if str(H)[0] == '-':
      rs, H = -1, abs(H)
    deg = (H*15) + (M/4) + (S/240)
    RA = '{0}'.format(deg*rs)
  
  if ra and dec:
    return (RA, DEC)
  else:
    return RA or DEC    

solar_system = celestial_system("earthsystem")
solar_system.simulate(end_t=1500, dt=1.6)

print(deg2HMS(ra=66.918277))
print(deg2HMS(dec=24.622590))
print(HMS2deg(ra='4 27 40.386', dec='+24 37 21.324'))

SEGMENTS = 48

if __name__ == '__main__':
    out_dir = sys.argv[1] if len(sys.argv) > 1 else None

    a = solar_system.render_orbits()
  
    # Adding the file_header argument as shown allows you to change
    # the detail of arcs by changing the SEGMENTS variable.  This can
    # be expensive when making lots of small curves, but is otherwise
    # useful.
    file_out = scad_render_to_file(a, out_dir=out_dir, file_header=f'$fn = {SEGMENTS};')
    print(f"{__file__}: SCAD file written to: \n{file_out}")
