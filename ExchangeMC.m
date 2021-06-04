function price = ExchangeMC(S1,S2,q1,q2,vol1,vol2,rho,r,T,NR)
rng(0);
Z1 = randn(1,NR);
Z2 = rho*Z1 + sqrt(1-rho^2)*randn(1,NR);
drift1 = (r - q1 - vol1^2/2)*T;
risk1 = vol1*sqrt(T);
drift2 = (r - q2 - vol2^2/2)*T;
risk2 = vol2*sqrt(T);
ST1 = S1*exp(drift1 + risk1*Z1);
ST2 = S2*exp(drift2 + risk2*Z2);
Intrinsic = max(0, ST1 - ST2);
price = mean(exp(-r*T)*Intrinsic);
end
