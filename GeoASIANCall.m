% Control Variate - Takehome Exam Question - Nick Irrer
function [Price, CI, Quality] = GeoASIANCall(S,K,r,q,vol,T,N,NPaths1,NPaths2)
% rng(0);
Underlying = GBMPaths(S,r,q,vol,T,N,NPaths1);
AVEPrice = mean(Underlying(:,1:N + 1) , 2);
GEOPrice = geomean(Underlying(:,1:N + 1) , 2);
% X
Intrinsic = exp(-r * T) * max(0,AVEPrice - K);
% Y
GEOIntrinsic = exp(-r * T) * max(0,GEOPrice - K);
% Approximate c
SampleCov = cov(Intrinsic,GEOIntrinsic);
c = SampleCov(1,2) / var(GEOIntrinsic);
% First random discarded to avoid bias
Underlying = GBMPaths(S,r,q,vol,T,N,NPaths2);
AVEPrice = mean(Underlying(:,1:N + 1) , 2);
GEOPrice = geomean(Underlying(:,1:N + 1) , 2);
% X
Intrinsic = exp(-r * T) * max(0,AVEPrice - K);
% Y
GEOIntrinsic = exp(-r * T) * max(0,GEOPrice - K);
%E(Y)
Vol_a = vol / sqrt(3);
B_a =.5 * (r - q - vol^2/6);
D1 = (log(S / K) + (B_a + Vol_a^2 / 2) *T) / (Vol_a * T^.5);
D2 = D1 - Vol_a * sqrt(T);
GEO_BS = S * exp((B_a - r) * T) * normcdf(D1)-K * exp(-r * T) * normcdf(D2);
%X - c(y - E(Y))
ControlVar = Intrinsic - c * (GEOIntrinsic - GEO_BS);
% ControlVar = Intrinsic - c*(1);
[Price, XX, CI] = normfit(ControlVar);
Quality = (CI(2) - CI(1)) / Price / 2;
end