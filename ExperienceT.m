function ExperienceT(dT,v,N)
% rng(0);
ExperienceTime = zeros(1,N);
for i = 1:N
    ExperienceTime(i) = icdf('gam', rand, dT/v, v);
end
plot(1:N,ExperienceTime);
end


