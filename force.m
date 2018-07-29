function[totalForce,tfx,tfy,tE] = force(ix,iy,jx,jy,L,radiuscut)  
len = length(jx);                        %find length of jx and the length of jy. 
                                         %This is the total number of interactions
totalForce=0;                                %intialize force
tfx = 0;                                 %intialize force in x direction
tfy = 0;                                 %intialize force in y direction
f = 0;                                   %intialize termporary force interaction
fx = 0;                                  %temp. x comp. of force for each interaction
fy = 0;                                  %temp. y comp. of force for each interaction
ileft = 1;
idown = 1;                              %initialize booleans that determine if i is to the left of, or below particle j
rMin = 0;
tE = 0;

%calculate the distance of particle i from particle j (note that this is attached to the update.m file)
for i = 1:1:len
    
    if abs(ix-jx(i))> L - abs(ix-jx(i))  %check for shortest distance in x direction over periodic boundary conditions
        rnX =  L - abs(-ix+jx(i));           %pick rnX to be the minimum. This avoids interactions between particles that are far apart
        
        if ix>jx(i)                      % if particles are far apart
            ileft = -1;
        end
        
    else
        rnX = abs(jx(i)-ix);    %distance for x coordinate
        
        if ix<jx(i)                 %if particles are close, then just calculate as normal, i.e. no need to invoke boundary conditions
            ileft = -1;
        end
        
    end
    if abs(iy-jy(i))> L - abs(iy-jy(i))  %check for shortest distance in y direction over periodic boundary conditions
        rnY =  L - abs(-iy+jy(i));           %pick rnX to be the minimum. This avoids interactions between particles that are far apart
        
        if iy>jy(i)                      % if particles are far apart
            idown = -1;
        end
        
    else
        rnY = abs(jy(i)-iy);
         %distance for y coordinate

        
        if iy<jy(i)                      %if particles are close, then just calculate as normal
            idown = -1;
        end
        
    end
    
    
    rn = sqrt(rnX^2+rnY^2);              %distance between pair of particles
    
    if rn<radiuscut && rn>=rMin              %check if particles are close enough to interact
        f = 24*((2/rn^13)-(1/rn^7));     %force between i and j, by Lennard-Jones potential
        fx = f*(rnX/rn)*ileft;              %x component of force
        fy = f*(rnY/rn)*idown;              %y component of force
        tfx = tfx + fx;                  %calculate net x component of force
        tfy = tfy + fy;                  %calculate net y component of force
        totalForce = totalForce+f;               %Cummulate the total force on i
        E = 4*((1/rn^12)-(1/rn^6));
        tE = tE+E;
        
        
        ileft = 1;
        idown = 1;                     %Reset booleans ileft and idown
        
        
    elseif rn<rMin
        f = 24*((2/rMin^13)-(1/rMin^7));
        fx = f*(rnX/rn)*ileft;              %x component of force
        fy = f*(rnY/rn)*idown;              %y component of force
        tfx = tfx + fx;                  %net force in x direction
        tfy = tfy + fy;                  %
        totalForce = totalForce+f;               %total force on f
        E = 4*((1/rn^12)-(1/rn^6));
        tE = tE+E;
        ileft = 1;
        idown = 1;
        
    elseif rn>radiuscut
        f=0;
        fx=0;
        fy=0;
        totalForce=0;
        E=0;
        tE=0;
        ileft=1;
        idown=1;
    end
end
end                                    