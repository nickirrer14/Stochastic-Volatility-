function [Price, CI, Quality] = ControlASIAN (S,K,r,q,vol,T,N,NPaths1,NPaths2)
rng(1);
Underlying = GBMPaths(S,r,q,vol,T,N,NPaths1);
AVEPrice = mean(Underlying(:,1:N+1) , 2);
% X
Intrinsic = exp(-r*T)*max(0,AVEPrice - K);
% Y
SUMPrice = sum(Underlying, 2);
% Approximate c

SampleCov = cov(SUMPrice,Intrinsic);
c = SampleCov(1,2)/var(SUMPrice);
%
% First random discarded to avoid bias
Underlying = GBMPaths(S,r,q,vol,T,N,NPaths2);
AVEPrice = mean(Underlying(:,1:N+1) , 2);
% X
Intrinsic = exp(-r*T)*max(0,AVEPrice - K);
% Y
SUMPrice = sum(Underlying, 2);
%E(Y)
dT=T/N;
ExpectedSUM = S*(1-exp(r*dT*(N+1)))/(1-exp(r*dT));
%X - c(y - E(Y))

ControlVar = Intrinsic - c*(SUMPrice - ExpectedSUM);
[Price, XX, CI] = normfit(ControlVar);
Quality = (CI(2)-CI(1))/Price/2;
end