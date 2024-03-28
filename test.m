Nx = 93;
Ny = 60;
Nt = 248;
T = 0.1;
p = 1;
X = 100;
Y = 100;
a = load('vent_1_mois.mat');
Ux = a.Ux;
Uy = a.Uy;
D = 0.1;
S = zeros(Nx+2, Ny+2);
S(3, 3) = 1;


v = zeros(p);

%[m_air,m_sol] = FinalScheme(Nx, Ny, X, Y, Nt, T, p, Ux, Uy, D, S, 1, zeros(Nx+2, Ny+2), v);
[m_air,m_sol] = FinalScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,sources,200,rain_matrix,v);