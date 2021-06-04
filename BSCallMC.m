function price = BSCallMC (S,K,r,q,vol,T,N)
%
rng(0);
drift = (r - q - vol^2/2)*T;
risk = vol*sqrt(T);
ST = S*exp(drift + risk*randn(N,1));
Intrinsic = max(0, ST - K);
price = mean(exp(-r*T)*Intrinsic);
end