# python3.8 -m pip install git+https://github.com/SolidCode/SolidPython.git
# python3.8 -m pip install viewscad
# sudo apt-get install openscad

import numpy as np
import sys

from solid import scad_render_to_file
from solid.objects import cube, cylinder, difference, translate, union, sphere
from solid.utils import right

# Gravitational constant m/s2
g = 6.674e-11

g = 6.674e-3

# XYZ history of celestial body
class history(object):
    def __init__(self):
        self.data=[]

    def record(self, X):
        self.data.append(X)

    def render_orbit(self):
        balls = union()
        for X in self.data:
            balls += translate((X[0], X[1], X[2]))(sphere(r=0.3))

        return balls

# Heavenly, or celestial, object
class celestial(object):
    def __init__(self, X=[0,0,0], V=[0,0,0], m=1.0):
        self.X=np.array(X) # position vector
        self.V=np.array(V) # speed vector
        self.m=m # object's mass
        self.history = history()

    def step(self, sunandplanets, dt=1):
        self.history.record(self.X)
        A = np.array([0,0,0])
        for p in sunandplanets.values():
            D = p.X - self.X
            r2 = np.sum(np.square(D))
            if r2 > 0:
                a = p.m / r2
                Ap = np.multiply(D, a / np.sqrt(r2))
                A = A + Ap

        A = A * g
        self.V = self.V + A * dt
        self.X = self.X + self.V * dt

    def render_orbit(self):
        return self.history.render_orbit()

# The solar system
class celestial_system(object):
    def __init__(self, name='earthsystem'):
        if name=='earthsystem':
            self.init_earth_system()

    def init_earth_system(self):
        self.sunandplanets = {}
        self.sunandplanets['sun'] = celestial(m = 10000)
        self.sunandplanets['earth'] = celestial(m = 1, X = [100, 0, 0], V = [0, 0.3, 0.3])

    def step(self, t=0, dt=1):
        for p in self.sunandplanets.values():
            p.step(self.sunandplanets, dt)

    def simulate(self, start_t=0, end_t=100, dt=1):
        for t in range(start_t, end_t, dt):
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


solar_system = celestial_system("earthsystem")
solar_system.simulate(end_t = 1000, dt=6)


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
