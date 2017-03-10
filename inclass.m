clear all
h=0.06;
m=2.4/h; n=3.0/h;
T=zeros(m+1,n+1);
T(:,1)=300; T(:,n+1)=50;
T(1,:)=75; T(m+1,:)=100;
T(1,1)=187.5; T(1,n+1)=62.5;
T(m+1,1)=200; T(m+1,n+1)=75;
x=0:h:2.4; y=0:h:3.0; iter=1000;

for k=0:iter
    T_old=T;
    for j=2:n
        for i=2:m
            T(i,j)=1/4*(T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1));
        end
    end
end
myerror=(abs(T-T_old)./T)*100;

[X,Y]=meshgrid(x,y);

figure(1)
surf(X,Y,T')

figure(2)
surf(X,Y,myerror')
        