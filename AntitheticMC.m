function [Price, CI, Quality] = AntitheticMC(S,K,r,q,vol,T,N)
rng(0);
drift = (r - q - vol^2/2)*T;
risk = vol*sqrt(T);
Samples = randn(N,1);
ST1 = S*exp(drift + risk*Samples);
ST2 = S*exp(drift + risk*(-Samples));
Intrinsic = 0.5*(max(0,ST1 - K) + max(0,ST2 - K));
[Price, xx, CI] = normfit(exp(-r*T)*Intrinsic);
Quality = (CI(2)-CI(1))/Price/2;
end