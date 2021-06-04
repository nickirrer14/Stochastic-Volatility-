function [Price, CI, Quality] = OptionCEV(S,K,r,q,vol0,T,N,NPaths,beta,IsCall)
% rng(0);
% Option Type
if IsCall
    Intrinsic = @(S) max(0, S-K);
else
    Intrinsic = @(S) max(0,K-S);
end
% Match initial vol
sigma = vol0 * S^((2-beta)/2);
% Payoff @ T
Payoff = zeros(NPaths,1);
dT = T/N;
for k = 1:NPaths
    Spot = S;
    for i = 1:N
        drift = (r - q - 0.5 * sigma^2 * Spot^(beta-2)) * dT;
        risk = sigma * (Spot^((beta-2)/2)) * dT^.5;
        Spot = Spot * exp(drift +risk*randn);
    end
    Payoff(k,1) = Intrinsic(Spot);
end
[Price, XX, CI] = normfit(exp(-r*T)*Payoff);
Quality = (CI(2)-CI(1))/Price/2;
end