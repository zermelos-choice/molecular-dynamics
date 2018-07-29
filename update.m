function [x,y,vx,vy,dxv,tE] = update(N,L,dt,vx,vy,x,y,T)      

tStepMax = ceil(T/dt);                                %total number of time steps
radiuscut = 3*L;                                           %Cut off distance for particle interaction. 
totalForce = zeros(1,N);                                  %initial net force on each particles
totalForceX = zeros(1,N);                                 %initial net force in the x direction on each particles
totalForceY = zeros(1,N);                                 %initial net force in the y direction on each particles
tE = zeros(T/dt,N);                                   %initial energy

x = padarray(x,[tStepMax-2,0], 'post');               %preallocate memory 
y = padarray(y,[tStepMax-2,0], 'post');               



for t = 2:1:tStepMax-1                                %loop for all time steps
    for i = 1:N                                       %loop that calculates total force and force in x and y direction for all particles
        xtemp = x(t,i);                               %determines x position
        ytemp = y(t,i);                               %determines y position
        jx = x(t,1:N ~=i);                            %determines x position for paricle j!=i
        jy = y(t,1:N ~=i);                            %determines x position for paricle j!=i
       
        % calculates net force (x and y) on particle i
        [Ftemp,ForceXtemp,ForceYtemp,tEtemp]= force(xtemp,ytemp,jx,jy,L,radiuscut);  
        
        %temporary calculations for force 
        totalForce(i)=Ftemp;                              %total net force calculated
        totalForceX(i)=ForceXtemp;                        %total net force in x direction
        totalForceY(i)=ForceYtemp;                        %total net force in y direction
        tE(t,i) = tEtemp;
    end
    
    for i=1:N                                             
        % Calculate the new x and y coordinates
        x(t+1,i) = 2*x(t,i) - x(t-1,i) + totalForceX(i)*dt^2; %calculate new x coordinate for particle i from force using prev steps
        y(t+1,i) = 2*y(t,i) - y(t-1,i) + totalForceY(i)*dt^2; %calculate new y coordinate for particle i from force using prev steps
        
        
        
        % Apply periodic boundary conditions, so that we may bring
        % particles that fall outside the boundary are brought back inside.
        if x(t+1,i)>L                                     %if x > L, bring particle to the left of L
            x(t+1,i) = rem(x(t+1,i),L);
        elseif x(t+1,i)<0                                 %if x < 0, bring particle up above 0
            x(t+1,i) = L+rem(x(t+1,i),L);
        end
        
        if y(t+1,i)>L                                     %if y > L, bring particle down below L
            y(t+1,i) = rem(y(t+1,i),L);
        elseif y(t+1,i)<0
            y(t+1,i) = L+rem(y(t+1,i),L);                 %if y < 0, bring particle up above 0
        end
        
        %distance and periodic boundary conditions
        if  abs(x(t+1,i)-x(t-1,i))< L-abs(x(t+1,i)-x(t-1,i))
            dx = x(t+1,i)-x(t-1,i);
        else
            if x(t+1,i)-x(t-1,i) > 0
                dx = -L+abs(x(t+1,i)-x(t-1,i));
            else
                dx = L-abs(x(t+1,i)-x(t-1,i));
            end
        end
        
        if  abs(y(t+1,i)-y(t-1,i))< L-abs(y(t+1,i)-y(t-1,i))
            dy = y(t+1,i)-y(t-1,i);
        else
            if y(t+1,i)-y(t-1,i) > 0
                dy = -L+abs(y(t+1,i)-y(t-1,i));
            else
                dy = L-abs(y(t+1,i)-y(t-1,i));
            end
        end
        
        
        vx(t,i) = dx/(2*dt);
        vy(t,i) = dy/(2*dt);
        dxv(t,i) = dx;
       
        end
        
        
    end
end

