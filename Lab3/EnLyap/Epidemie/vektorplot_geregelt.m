clear all;
close all;
par_beta = 1;
par_gamma = 0.1;
par_delta = 0.01;

c1 = 1;
c2 = 0.1;
c = 1000;

ii=0:0.03:1
rr=0:0.03:1

u=zeros(34);

for x=1:34
  for y=1:34
      i=ii(x)
      r=rr(y)
      u1= -c2 * (r - 0.1e1 + 0.2e-1 * exp(log(i) + 0.3912023005e1) + par_gamma / par_beta - c1 * (log(i) + 0.3912023005e1) / par_beta) - 0.2e-1 * par_gamma * exp(log(i) + 0.3912023005e1) + par_delta * r + 0.5000000000e2 * (-0.2e-1 * exp(log(i) + 0.3912023005e1) + c1 / par_beta) * (0.2e-1 * par_beta * exp(log(i) + 0.3912023005e1) * (0.1e1 - 0.2e-1 * exp(log(i) + 0.3912023005e1) - r) - 0.2e-1 * par_gamma * exp(log(i) + 0.3912023005e1)) / exp(log(i) + 0.3912023005e1) + 0.1e1 / c * par_beta * (log(i) + 0.3912023005e1);
if(1)
      if u1<0
          u1=0;
      end
      if u1>0.1
          u1=0.1;
      end
end
      u(x,y)=u1;
  end
end



[X,Y] = meshgrid(0:0.03:1,0:0.03:1);
if (1)
    figure(1)
    U = par_beta*i.*(1-i-r)-par_gamma*i;
    V = par_gamma*i-par_delta*r+u;
    U = U ./ sqrt(U.^2+V.^2);
    V = V ./ sqrt(U.^2+V.^2);
    quiver(X,Y,U,V,0.5);
    title('normalisiertes Vektorfeld für u geregelt');
    ylabel('dr (resistent)');
    xlabel('di (infected)');
end;