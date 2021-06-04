function IMC = IMCExample2(N)
% rng(1);
g = @(x) exp(x)^2;
value = zeros(N,1);
for i = 1:N    
    x = randn;
    if (x > 0) && (x < 1)    
        value(i) = g(x)/normpdf(x);
    end
end
IMC = mean(value);