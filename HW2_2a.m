clear vars;
clc;

h=0.01;
x0=0; x_end=1; x=x0:h:x_end;
y0=0; y_end=1; y=x0:h:y_end;

f=@(x,y) exp(pi.*x).*sin(pi.*y)+(0.5.*(x.*y).^2);
[X,Y]=meshgrid(x,y);
Z=f(X,Y);

surf(X,Y,Z)
title('z=e^{\pi x}sin(\pi y)+0.5(xy)^2')
zlabel('z'); xlabel('x');ylabel('y')

