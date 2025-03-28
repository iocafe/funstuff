#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pygame
#from game import Game

SCREEN_WIDTH = 1024
SCREEN_HEIGHT = 768

def main():
    # Initialize all imported pygame modules
    pygame.init()
    # Set the width and height of the screen [width, height]
    screen = pygame.display.set_mode((SCREEN_WIDTH,SCREEN_HEIGHT))
    # Set the current window caption
    pygame.display.set_caption("TacDogMathematics")
    #Loop until the user clicks the close button.
    done = False
    # Used to manage how fast the screen updates
    clock = pygame.time.Clock()
    
    matthew = pygame.image.load("matthew.jpg").convert();

    screen.blit(matthew,(64,50))

    done = False;
   
    """# Create game object
    game = Game()
    # -------- Main Program Loop -----------"""
    while not done:
        # --- Process events (keystrokes, mouse clicks, etc)
        # done = game.process_events()
        # --- Game logic should go here
        # game.run_logic()
        # --- Draw the current frame
        screen.blit(matthew,(64,50))

        pygame.display.flip()
        #game.display_frame(screen)
        # --- Limit to 30 frames per second
        clock.tick(30)
    
    # Close the window and quit.
    # If you forget this line, the program will 'hang'
    # on exit if running from IDLE.
    pygame.quit()

if __name__ == '__main__':
    main() 
