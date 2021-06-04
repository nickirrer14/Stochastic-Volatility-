function HestonPaths(S,r,q,VarOfPrice0,kappa,theta,VolOfVariance0,corr,T,N)
% rng(0);
dT = T/N;
HPath = zeros(1,N+1);
HPath(1,1) = S;
sigmaV = VolOfVariance0 * sqrt(VarOfPrice0);
VT = VarOfPrice0; 
    for i = 1:N
    drift = (r - q - .5 * VT) * dT;
    risk = sqrt(VT) * sqrt(dT) ;               
    Z1 = randn;                
    HPath(i+1) = HPath(i) * exp(drift + risk*Z1);  
    % Observe stochastic Volatility
    driftV =(kappa * ( theta - VT ) - 0.5 * sigmaV^2 )* dT / VT;
    riskV = sigmaV * sqrt(dT) / sqrt(VT);
    Z2 = corr*Z1 + sqrt(1 - corr^2)*randn;        
        VT = VT * exp(driftV + riskV*Z2);        
    end
plot(0:N,HPath);
end
