function [totalvelo] = probdist(vx,vy)

totalvelo = sqrt(vx.^2+vy.^2); %calculate total velocity magnitude
figure(3);
histogram(totalvelo, 'Normalization', 'pdf');
xlabel('v');
ylabel('P(v)');
title('Speed distribution of N=20 particles');
% export_fig probdist20.png
mean=trimmean((.5/120)*totalvelo,20);
R=sum(mean);

end
