function Paths = GBMPaths (S,r,q,vol,T,N,NPaths)
% rng(0);
Paths = zeros(NPaths, N+1);
Paths(:,1) = S;
dT = T/N;
drift = (r - q - vol^2/2)* dT;
risk = vol*sqrt(dT);
for k=1:NPaths
    for i=1:N
        Paths(k,i+1) = Paths(k,i)*exp(drift + risk*randn);
    end
end
% for k=1:NPaths
%     plot(0:dT:T,Paths(k,:));
%     hold on;
% end
% hold off;
end