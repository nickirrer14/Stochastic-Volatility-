function [Price, CI, Quality] = QualityMC(S,K,r,q,vol,T,N)
rng(0);
drift=(r-q-vol^2/2)* T;
risk = vol*sqrt(T);
ST = S*exp(drift + risk*randn(N,1));
Intrinsic = max(0, ST - K);
[Price, xx, CI] = normfit(exp(-r*T)*Intrinsic);
Quality = (CI(2)-CI(1))/Price/2;
end