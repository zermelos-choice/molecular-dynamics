N = 50; %Number of particles
L = 10; %Size of box
dt = .02; % time step (This will always be at 2 picoseconds)
dr = .01; %deviation from lattice
v0 = 1;%initial velocity
T = 20; %total time 

% Initialize
[x,y,vx,vy] = initialize(N,L,dt,dr,v0);

% Update subroutine as given in ex 9.1
[x,y,vx,vy,dx,tE] = update(N,L,dt,vx,vy,x,y,T);
%note: we should call force.m in the update routine
%inside force is where we add in boundary conditions.
 %update x randomly by ex 9.1
 

 
 
% The following plots the particles
% Be sure to comment out videowriter unless you want a movie.
% If you need to write more videos, be sure to uncomment m=..., open,
% getframe, writevideo, and close(m).

 m=VideoWriter('100particles.avi');
 open(m);
figure (1)
for t=1:1:(T/dt)
    plot(x(t,:),y(t,:),'.','MarkerSize', 25)
    axis([0 L 0 L])
    xlabel('X')
    ylabel('Y')
    title('N=100 Argon particles in a 10x10 box')
    M(t)=getframe(gcf); % leaving gcf out crops the frame in the movie.
    writeVideo(m,M(t));
    drawnow
end
 close(m);
%videos can be found at:
%http://bit.ly/2sayx0X
%http://bit.ly/2rcBvom
%http://bit.ly/2rPtmal


% Determine probability distribution of speed
totalvelo = sqrt(vx.^2+vy.^2); %calculate total velocity magnitude
figure(3);
histogram(totalvelo, 'Normalization', 'pdf');
xlabel('v');
ylabel('P(v)');
title('Speed distribution of N=20 particles');
% export_fig probdist20.png


% references: 
% Giorodano's Computational Physics text
% http://www.cchem.berkeley.edu/chem195/index.html
% https://www.physics.purdue.edu/~hisao/book/www/Computational%20Physics%20using%20MATLAB.pdf


