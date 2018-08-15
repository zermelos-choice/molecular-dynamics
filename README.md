# molecular-dynamics
This program simulates Argon particles on a Torus in two dimensions. 

The forces are derived from Van der Waals interaction, following the method from the book Computational Physics by Giodano and Nakanishi. When executed, the code will simulate N Argon atoms in an LxL space using periodic boundary conditions. Atoms starting positions are chosen by small deviations from points chosen randomly from lattice, and atoms are given an initial velocity in a random direction.



To execute the program use proj2.m, which calls the force, initialize, update and probdist functions.  
Videos:
L=10,N=20 
https://youtu.be/y-C8Ldw2mvw

L=10,N=50
https://youtu.be/uXhbRc4NiLA
