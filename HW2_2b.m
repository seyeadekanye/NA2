clear all;
clc;

m=3;
h=1/(m+1);
H=h^2;
%-----------------------Define mega matrix---------------------------------
I=eye(m); e=ones(m,1); T=spdiags([e -4*e e],[-1 0 1],m,m);
S=spdiags([e e],[-1 1],m,m);
A=(kron(I,T)+kron(S,I));
%--------------------------------------------------------------------------
U=zeros(m+2);
x=0:h:1; y=0:h:1;
f=@(x,y) (x.^2)+(y.^2);
f1=@(x,y) exp(pi.*x).*sin(pi.*y)+(0.5.*(x.*y).^2);
[X,Y]=meshgrid(x,y);
Z=f1(X,Y);

U(1,:)=0;
U(m+2,:)=0.5.*(x.^2);
U(:,1)=sin(pi.*y);
U(:,m+2)=exp(pi).*sin(pi.*y)+(0.5.*(y.^2));

FF=f(X,Y);
F=f(X,Y);
F(:,[1 m+2])=[]; F([1 m+2],:)=[]; 
for j=1
    for i=2:m-1
        F(j,i)=(H*F(j,i))-U(j,i+1);
    end
end
F(1,1)=(H*F(1,1))-U(1,2)-U(2,1);
F(1,m)=(H*F(1,m))-U(2,m+2)-U(1,m+1);

for j=2:m-1
    F(j,1)=(H*F(j,1))-U(j+1,1);
    for i=2:m-1
        F(j,i)=H*F(j,i);
    end
    F(j,m)=(H*F(j,m))-U(j+1,m+2);
end

for j=m
    for i=2:m-1
        F(j,i)=(H*F(j,i))-U(j+2,i+1);
    end
end
F(m,1)=(H*F(m,1))-U(m+1,1)-U(m+2,2);
F(m,m)=(H*F(m,m))-U(m+1,m+2)-U(m+2,m+1);


% for i=2:m+1
%     for j=2:m+1
%         F(i-1,j-1)=(h^2)*F(i-1,j-1)-(U(i-1,j)+U(i+1,j)+U(i,j-1)+U(i,j+1));
%     end
% end

rhs = reshape(F,m^2,1);
u=reshape((A\rhs)',m,m);

for j=2:m+1
    for i=2:m+1
        U(j,i)=u(j-1,i-1);
    end
end


figure(1)
surf(X,Y,U)

figure(2)
surf(X,Y,abs(U-Z))
