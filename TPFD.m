function [u,UTrue,x,S] = TPFD(x0,xf,h,a,b,c,f,U,alpha,beta)
%TPFD is a three point finite difference method
%x0 - initial space value
%xf - final space value
%h - step size
%a,b,c - constants
%alpha,beta - boundary conditions
%f-f(x)
%u - function we are approximating
x=x0:h:xf;
x=x';
n=ceil(((xf-x0)./h)+1);
N=n-2;
% alpha=0; beta=2;
%--------------------Defining Matrix---------------------------------------
D = sparse(1:N,1:N,((c*h.^2)+(2*a)),N,N);
E = sparse(2:N,1:N-1,(-a-(b.*h)/2),N,N);
F = sparse(1:N-1,2:N,(-a+(b.*h)/2),N,N);
S = (1/h.^2)*(E+D+F);
%--------------------------------------------------------------------------

%------------------Right hand side of linear system------------------------
B=zeros;
for i=1:N
    B(i)=f(x(i+1));
end
B(1)=B(1)-((-a-((b.*h)/2))*(alpha./h.^2));
B(N)=B(N)-((-a+((b.*h)/2))*(beta./h.^2));
B=B';
%--------------------------------------------------------------------------

u=S\B;
u=[alpha,u',beta]';
UTrue=U(x);
S=full(S)
spy(S)
end

