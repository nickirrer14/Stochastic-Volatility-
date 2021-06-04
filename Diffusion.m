function Path = Diffusion (S,r,q,vol,T,N)
% rng(0);
Path = zeros(1, N+1);
Path(1,1) = S;
dT = T/N;
drift = (r - q - vol^2/2)* dT;
risk = vol*sqrt(dT);
    for i=1:1:N
        Path(1,i+1) = Path(1,i)*exp(drift + risk*randn);
    end
plot(0:dT:T,Path);