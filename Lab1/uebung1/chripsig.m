function [u,t] = chripsig(U, w_s, w_e, N, Ta)


k=0:1:(N-1);

rk= U * sat (10*k/N) .* sat(10*(N-k)/N);

uk = rk .* sin(w_s*k*Ta+(w_e-w_s)* (k*Ta).^2 / (2*N*Ta));

U0 = mean(uk);

u=uk+U0;

t=k.*Ta;

end

