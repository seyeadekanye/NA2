clear vars;
clc;
h=1;
m=5; I=eye(m); e=ones(m,1); T=spdiags([e -4*e e],[-1 0 1],m,m);
S=spdiags([e e],[-1 1],m,m);
A=(kron(I,T)+kron(S,I))/h^2;
