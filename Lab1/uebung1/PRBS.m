function [u,t] = PRBS(U,Pp,Ta)
%Ordning Op = 10
%Uberabtastung Pp>=1
if Pp < 1
    Pp=1
    
N=(2^10-1)*Pp;

p=[0,0,0,0,0,0,0,0,0,1];

for i=1:N
    pk = mod(1*p(7-1+i)+1*p(10-1+i),2)
    p=[p, pk]
end

p = p(10:N)
t=Ta*N
end

