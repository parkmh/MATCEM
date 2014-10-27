CEMOPT = cemoption;
CEMOPT.set('N',[64 64 1]);
CEMOPT.set('h',[1/64 1/64 0]);

CEM = cem(CEMOPT);
z = CEM.generate_vector;
