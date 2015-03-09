function r = matern32_cov(x)
m = sqrt(3)*x;
r = (1+m)*exp(-m);