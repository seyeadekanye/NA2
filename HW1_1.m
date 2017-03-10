clear vars;

%-------------------------------------------------------------
% Determining Coefficients
A= [1 1 1 1 1;2 1 0 -1 -2;4 1 0 1 4;8 1 0 -1 -8;16 1 0 1 16];
syms h;
b=[0;0;2/(h^2);0;0];
uvec=A\b;
%-------------------------------------------------------------

f = @(x) sin(2*x);
U = -4*sin(2); % True solution
% h = [1*10^(-1),5*10^(-2),1*10^(-2),5*10^(-3),1*10^(-3)];
h=[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1];
err = zeros(1,length(h));
xbar=1;
u=zeros(1,length(h));
slope=zeros(1,length(h)-1);

for i=1:length(h)
    u(i)=(1/(12*(h(i)^2)))*(-f(xbar-(2*h(i)))+16*f(xbar-h(i))...
        -30*f(xbar)+16*f(xbar+h(i))-f(xbar+(2*h(i))));
    err(i)=abs(u(i)-U);
end

for j=1:length(h)-1
    slope(j)=log10(err(j+1)/err(j))/log10(h(j+1)/h(j));
end

%plot and slope
loglog(h,err,'LineWidth',2)
grid on
title('log(h) vs log(error)')
xlabel('log(h)')
ylabel('log(error)')

fprintf('n \t h(n)   \t error(n)   \t    slope\n')
fprintf('--------------------------------------------------\n')
for n=1:length(h)-1
    fprintf('%d \t %2.6f \t %2.6f \t %2.6f\n',n,h(n),err(n),slope(n))
end
