function r = matern52_cov(x)
m = sqrt(5)*x;
r = (1+m+m^2/3)*exp(-m);