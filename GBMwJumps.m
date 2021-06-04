function GBMwJumps(S,r,q,vol,T,N,alphaJ,volJ,lambdaJ)
% rng(0);
Paths = zeros(1, N+1);
WithJumps = zeros(1,N+1);
Paths(1,1) = S;
WithJumps(1,1) = S;
dT = T/N;
% GBM
drift = (r - q - vol^2/2)* dT;
risk = vol*sqrt(dT);
% WithJumps
k = (exp(alphaJ) - 1); 
driftJ = (r - q + lambdaJ * k - vol^2/2) * dT;
    for i=1:N
        Z = randn;
        X = exp(drift + risk * Z);
        Paths(1,i+1) = Paths(1,i) * X;
        % With Jumps
        X = exp(driftJ + risk * Z);
        m = icdf('Poisson',rand, lambdaJ*dT);
        Y = exp(m * (alphaJ - .5*volJ^2) + volJ * sum(randn(1,m)));
        WithJumps (1,i+1) = WithJumps(1,i) * X * Y;
    end
plot(0:dT:T,Paths);
hold on;
plot(0:dT:T,WithJumps);
hold off;
end