function [Price, CI, Quality] = AsianMC (S,K,r,q,vol,T,N,NPaths)
% Arithmetic Average Call - Monte Carlo
rng(1);
Intrinsic = zeros(NPaths,1);
for i = 1:NPaths
    Underlying = GBMPaths(S,r,q,vol,T,N,1);
    AVEPrice = mean(Underlying(2:N+1));    
    Intrinsic(i) = max(0,AVEPrice - K);
end
[Price, XX, CI] = normfit(exp(-r*T)*Intrinsic);
Quality = (CI(2)-CI(1))/Price/2;
end