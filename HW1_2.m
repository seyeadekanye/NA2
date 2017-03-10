clear vars;
%-------------Function scheme is exact for---------------------------------
% U = @(x) 2*(x.^2);
% Up= @(x) 4*x;
% Upp= @(x) 4;
%--------------------------------------------------------------------------

%-------------Function scheme is not exact for-----------------------------
U = @(x) cos(x)+exp((2*x));
Up= @(x) -sin(x)+(2*(exp(2*x)));
Upp= @(x) -cos(x)+(4*(exp(2*x)));
%--------------------------------------------------------------------------

%-----------------Parameters for function----------------------------------
x0=0; xf=1;
% H=0.1; 
H=[(xf-x0)/28,(xf-x0)/25,(xf-x0)/22,(xf-x0)/20,(xf-x0)/15,(xf-x0)/13,(xf-x0)/11,(xf-x0)/10,];
alpha=U(x0); beta=U(xf);
a=1;b=0;c=0;
f = @(x) (-a*Upp(x))+(b*Up(x))+(c*U(x));
%--------------------------------------------------------------------------
errNorm=zeros;
for i=1:length(H)
    h=H(i);
    [u,UTrue,x,S]=TPFD(x0,xf,h,a,b,c,f,U,alpha,beta);
    errNorm(i)=norm(u-UTrue,inf);
end

slope=zeros;
for j=1:length(H)-1
    slope(j)=log10(errNorm(j+1)/errNorm(j))/log10(H(j+1)/H(j));
end


%-----------------Plots and slope------------------------------------------
% plot(x,UTrue,'r',x,u,'*b','LineWidth',2)
% legend('Exact Solution','Numerical Approx.','Location','Best')
% grid on
% err=abs(UTrue-u)

loglog(H,errNorm,'LineWidth',2)
xlabel('log(h)')
ylabel('log(error)')
grid on
% 
fprintf('n \t h(n)   \t error(n)   \t    slope\n')
fprintf('--------------------------------------------------\n')
for n=1:length(H)-1
    fprintf('%d \t %2.6e \t %2.6e \t %2.6f\n',n,H(n),errNorm(n),slope(n))
end
%--------------------------------------------------------------------------
