% Control Variate - Takehome Exam Question - Nick Irrer
function [Price, CI, Quality] = Geofarts(S,K,r,q,vol,T,N,NPaths1,NPaths2)
% rng(0);
Underlying = GBMPaths(S,r,q,vol,T,N,NPaths1);
AVEPrice = mean(Underlying(:,1:N+1) , 2);
GEOPrice = geomean(Underlying(:,1:N+1) , 2);
% X
Intrinsic = exp(-r*T)*max(0,AVEPrice - K);
% Y
GeoIntrinsic = exp(-r*T)*max(0,GEOPrice - K);
% Approximate c
SampleCov = cov(GeoAsian,GeoIntrinsic);
c = SampleCov(1,2)/var(GeoIntrinsic);
%
% First random discarded to avoid bias
Underlying = GBMPaths(S,r,q,vol,T,N,NPaths2);
GEOPrice = geomean(Underlying(:,1:N+1) , 2);
% X
Intrinsic = exp(-r*T)*max(0,AVEPrice - K);
% Y
GeoIntrinsic = exp(-r*T)*max(0,GEOPrice - K);
%E(Y)
volA = vol/sqrt(3);
bA =.5*(r-q-vol^2/6);
d1 = (log(S/K)+(bA+volA^2/2)*T)/(volA*T^.5);
d2 = d1 - volA*T^.5;
GeoBS = S*exp((bA-r)*T)*normcdf(d1)-K*exp(-r*T)*normcdf(d2);
%X - c(y - E(Y))
ControlVar = Intrinsic - c*(GeoIntrinsic - GeoBS);
% ControlVar = Intrinsic - c*(1);
[Price, XX, CI] = normfit(ControlVar);
Quality = (CI(2)-CI(1))/Price/2;
end

% GeoIntrinsic - GeoBS