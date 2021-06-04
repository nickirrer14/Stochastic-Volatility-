function VolPaths (Variance0,kappa,theta,VolOfVariance0,T,N)
% rng(0);
dT = T/N;
VolPath = zeros(1,N+1);
sigmaV = VolOfVariance0 * sqrt(Variance0);
VolPath(1,1) = Variance0;
    for i =1:N     
        drift = (kappa * ( theta - VolPath(i) ) - 0.5 * sigmaV^2 )* dT /VolPath(i);        
        risk = sigmaV * sqrt(dT) /sqrt(VolPath(i)) ;        
        VolPath(i+1) = VolPath(i) * exp(drift + risk*randn);
    end
VolPath = VolPath.^0.5;
plot(0:N,VolPath);
end
