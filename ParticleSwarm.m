function [x,y] = ParticleSwarm(fxy,nparticles,Kmax,wmax,wmin,c1,c2,xinitmax,yinitmax,speedmax)
%returns the position (x,y) of a global minimum of a function fxy.
%nparticles is the number of particles used to search for the minimum
%Kmax is the number of iterations the particles have to find the minimum
%wmax is the maximum inertial state of the system
%wmin is the minimum inertial state of the system
%c1 is the weight for updating velocities to be pulled towards the group
%center
%c2 is the weight for updating velocities to be pulled towards the global
%center
%for this algorithm the group center is the global center as there is only
%one group
%xinitmax and yinitmax are the maximum position away from the origin where
%a particle can be spawned
%speedmax is the maximum velocity a particle can be spawned with


%history of best positions for ploting
best_hist = zeros(Kmax,3);

%initialise n Paricles (index 1 and 2 are position, 3 and 4 are velocity
%,and 5 and 6 are best position for particle
particles = zeros(nparticles,6);
for i = 1:nparticles
    particles(i,1) = (-1 + 2*rand)*xinitmax;
    particles(i,2) = (-1 + 2*rand)*yinitmax;
    particles(i,3) = (-1 + 2*rand)*speedmax;
    particles(i,4) = (-1 + 2*rand)*speedmax;
    particles(i,5) = particles(i,1);
    particles(i,6) = particles(i,2);
end

%initialize best position at particle 1's position
bestpos = [particles(1,1),particles(1,2)];
for K = 1:Kmax
    %add to the history for ploting purposes
    best_hist(K,1)= bestpos(1);
    best_hist(K,2)= bestpos(2);
    best_hist(K,3)= fxy(bestpos(1),bestpos(2));
    
    %calculate w (inertial state)
    w = wmax-((wmax-wmin)/Kmax)*K;
   %evaluate best location of swarm
   for i = 1:nparticles
      posev = fxy(particles(i,1),particles(i,2));
      if posev < fxy(particles(i,5),particles(i,6))
         %update best individual position
          particles(i,5) = particles(i,1);
          particles(i,6) = particles(i,2);
      end
      if posev < fxy(bestpos(1),bestpos(2))
          bestpos(1) = particles(i,5);
          bestpos(2) = particles(i,6);
      end
      % update the velocity of the particle
      particles(i,4) = w*particles(i,4) + rand*c1*(bestpos(1)-particles(i,1)) + rand*c2*(bestpos(1)-particles(i,1));
      particles(i,5) = w*particles(i,5) + rand*c1*(bestpos(2)-particles(i,2)) + rand*c2*(bestpos(2)-particles(i,2));
      % update position of the particle
      particles(i,1) = particles(i,1) + particles(i,4);
      particles(i,2) = particles(i,2) + particles(i,5);
   end
   
end
x = bestpos(1);
y = bestpos(2);
plot3(best_hist(:,1),best_hist(:,2),best_hist(:,3))
end