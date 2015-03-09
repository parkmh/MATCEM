CEMOPT = cemoption;
CEMOPT.set('N',[64 64 1]);
CEMOPT.set('h',[1/64 1/64 0]);
CEMOPT.set('distfun','@(x)l2dist(x,[0.6, 0.6, 0.6])');
CEMOPT.set('covfun','matern52_cov')
CEM = cem(CEMOPT);
z = CEM.generate_vector;
pcolor(reshape(z,64,64));shading interp
