function d = l2dist(x,l)
d = 0;
for i = 1 : length(x)
    d = d + x(i)^2/l(i)^2;
end
d = sqrt(d);