function [x,y] = SimAnneal(fxy,alpha,tempinit,stopcond,stepsize,xinitmax,yinitmax)

%initialize x,y
x = (-1 + 2*rand)*xinitmax;
y = (-1 + 2*rand)*yinitmax;

histxy = [x,y,fxy(x,y)];
%initialize temperature and energy
energy = fxy(x,y);
temp = tempinit;
while temp>stopcond
    %random disturbance
    x1 = x +((-1 + 2*rand)*stepsize);
    y1 = y +((-1 + 2*rand)*stepsize);
    newenergy = fxy(x1,y1);
    deltaenergy = newenergy-energy;
    if deltaenergy<0
        %automatically accept lower energy state
        energy = newenergy;
        x = x1;
        y = y1;
    else
        %probabilistic accpetance
        if rand<exp(-deltaenergy/temp)
            energy = newenergy;
            x = x1;
            y = y1;
            %else keep old state
        end
    end
    %update temperature
    temp = alpha*temp;
    %add to history
    histxy = [histxy;x,y,fxy(x,y)];
end
plot3(histxy(:,1),histxy(:,2),histxy(:,3));
end