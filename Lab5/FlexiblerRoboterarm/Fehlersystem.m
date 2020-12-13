run params

A = [0 0 1 0; 0 0 0 1; -c / I__1 c / I__1 -d__1 / I__1 0; c / I__2 (m * g * l * sin(pi / 0.2e1) - c) / I__2 0 -d__2 / I__2;];
B = [0; 0; 0.1e1 / I__1; 0;];
C = [0 1 0 0;];
D = [0];

sysc=ss(A,B,C,D)

rlocus(sysc)