import numpy as np
from solid import translate
# from solid.utils import *

#pip install git+https://github.com/SolidCode/SolidPython.git
# pip install viewscad

# Gravitational constant m/s2
g = 6.674e-11

# Heavenly, or celestial, object
class celestial(object):
    def __init__(self, X=[0,0,0], V=[0,0,0], m=1.0):
        self.X=np.array(X) # position vector
        self.V=np.array(V) # speed vector
        self.m=m # object's mass

    def step(self, sunandplanets, dt=1):
        for p in sunandplanets.values():
            D = p.X - self.X
            r2 = np.sum(np.square(D))
            A = np.array([0,0,0]);
            if r2 > 0:
                a = p.m / r2
                Ap = np.multiply(D, a / np.sqrt(r2))
                A = A + Ap

        A = A * g
        self.V = self.V + A * dt
        self.X = self.X + self.V * dt

# The solar system
class celestial_system(object):
    def __init__(self):
        self.sunandplanets = {}
        self.sunandplanets['sun'] = celestial(m = 100)
        self.sunandplanets['earth'] = celestial(m = 1, X = [2, 3, 4], V = [2, 3, 4])

    def step(self):
        for p in self.sunandplanets.values():
            p.step(self.sunandplanets)


solar_system = celestial_system()
solar_system.step()


