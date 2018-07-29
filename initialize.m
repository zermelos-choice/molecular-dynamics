function [x,y,vx,vy]=initialize(N,L,dt,dr,v0)

% Set initial positions and velocities of the particles
sigma=1;
numedges=L/sigma;

for i=1:(numedges)
    lattice(1,1+(i-1)*numedges:i*numedges)=i-1;
end
for j=1:(numedges)^2
    lattice(2,j)=mod(j-1,numedges);
end

Pos=datasample(lattice',N,'Replace',false)'/sigma;


% Displace each particle randomly from its starting position
vc = zeros(1,N);            %particles to disperse                 
vc(1:N) = v0;               %assign initial velocity

lx=Pos(1,:);
ly=Pos(2,:);

%begin actual updating process
for i=1:N
    x0(i) = lx(i) + 2*(rand-0.5)*dr;                %update x randomly by ex 9.1
    y0(i) = ly(i) + 2*(rand-0.5)*dr;                 %update x randomly by ex 9.1
    vx0(i) = 2*(rand-0.5)*vc(i);                      %calculate a random vx0 for particle i
    vy0(i) = 2*(rand-0.5)*vc(i);                      %calculate a random vy0 for particle i
    xPrev(i) = x0(i) - vx0(i)*dt;                  %calculate previous step the Verlet method
    yPrev(i) = y0(i) - vy0(i)*dt;                 
end

% position output
x = [xPrev;x0];                                   
y = [yPrev;y0];                                    
% Velocity output
vx =[vx0;vx0];                                     
vy = [vy0;vy0];                                   
end                                               

