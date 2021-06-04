function [Price, CI, Quality] = ControlMC (S,K,r,q,vol,T,NR1,NR2)
% Stock Price as a control variate
rng(1);
drift = (r - q - vol^2/2)*T;
risk = vol*sqrt(T);
% Y
ST = S*exp(drift + risk*randn(NR1,1));
% E(Y) = Theta
ExpectedST = S*exp((r-q)*T);
% sigmaY
VarST = (S^2)*exp(2*(r-q)*T)*(exp((vol^2)*T) - 1);
% Approximate C
%X
Intrinsic = exp(-r*T)*max(0, ST - K);
% Estimate Cov(X,Y)
SampleCov = cov(ST,Intrinsic);
c = SampleCov(1,2)/VarST;
% 
% First random discarded to avoid bias
ST = S*exp(drift + risk*randn(NR2,1));
Intrinsic = exp(-r*T)*max(0, ST - K);
ControlVar = Intrinsic - c*(ST - ExpectedST);
[Price, XX, CI] = normfit(ControlVar);
Quality = (CI(2)-CI(1))/Price/2;
end
