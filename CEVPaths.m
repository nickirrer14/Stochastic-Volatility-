function CEVPaths(S,r,q,vol0,T,N,beta)
%rng(0);
dT = T/N;
Path = zeros(1,N+1);
Path(1,1) = S;
% Match initial vol
sigma = vol0*S^((2-beta)/2);
    for i = 1:N
        drift = (r - q - 0.5*sigma^2*Path(1,i)^(beta-2))* dT;
        risk = sigma * Path(1,i)^((beta-2)/2) * dT^.5;
        Path(1,i+1) = Path(1,i) * exp(drift +risk*randn);
    end
plot(0:dT:T,Path);
end
