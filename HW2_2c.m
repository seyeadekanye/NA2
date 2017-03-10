clear all;
clc;

m=16;
h=1/(m+1);
U=zeros(m+2);
x=0:h:1; y=0:h:1;
[X,Y]=meshgrid(x,y);
g=@(x,y) exp(pi.*x).*sin(pi.*y)+(0.5.*(x.*y).^2);
f=@(x,y) (x.^2)+(y.^2);
F=f(X,Y);
U(1,:)=0;
U(m+2,:)=0.5.*(x.^2);
U(:,1)=sin(pi.*y);
U(:,m+2)=exp(pi).*sin(pi.*y)+(0.5.*(y.^2));
max_iter=300;
for iter=0:max_iter
    for j=2:m+1
        for i=2:m+1
            U(i,j)=0.25*(U(i-1,j)+U(i+1,j)+U(i,j-1)+U(i,j+1)-(h^2*F(i,j)));
        end
    end
end

Utrue=g(X,Y);

surf(X,Y,abs(U-Utrue))