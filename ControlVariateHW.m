function [price, CI, Quality] = ControlVariateHW (S,K,r,T,vol,q,N,NP1,NP2)
Underlying = GBMPaths (S,r,q,vol,T,N,NP1);
AVEPrice = mean(Underlying(:,2:N+1) , 2);
%X
Intrinsic = exp(-r*T)*max(0,AVEPrice - K);
%Y
Intrinsicgeo = geomean(Underlying(:,2:N+1),2);
asian_geo = exp(-r*T)*max(0,Intrinsicgeo - K);
% Est Cov(X,Y) & var(Y) to calculate c
SampleCov = cov(asian_geo,Intrinsic);
c =  SampleCov(1,2)/var(Intrinsicgeo);
% Record E(Y)
vola = vol/((3)^0.5);
Ba = 0.5 * (r - q- ((vol)^2)/6);
d1 = ((log(S/K)+ (Ba + ((vola)^2)/2))* T)/(vola * (T)^0.5);
d2 = d1 - (vola * (T)^0.5);
ExpectedSUM = (S*(exp(Ba - r)*T)* normcdf(d1)) - (K*(exp(-r*T))* normcdf(d2));

% First random discarded to avoid bias
Underlying = GBMPaths (S,r,q,vol,T,N,NP2);
AVEPrice = mean(Underlying(:,2:N+1) , 2);
% Observe X & Y
Intrinsic = exp(-r*T)*max(0,AVEPrice - K);
Intrinsicgeo = geomean(Underlying(:,2:N+1),2);
asian_geo = exp(-r*T)*max(0,Intrinsicgeo - K);
% adjust according to control variate
ControlVar = Intrinsic - c*(asian_geo - ExpectedSUM);
[price, XX, CI] = normfit(ControlVar);
Quality = (CI(2)-CI(1))/price/2;
end
