Nx = 93;
Ny = 60;
Nt = 248;
T = 0.1;
p = 1;
X = 1;
Y = 1;
a = load('vent_1_mois.mat');
Ux = a.Ux;
Uy = a.Uy;
D = 0.1;



v = zeros(p);
%[m_air,m_sol] = FinalScheme(Nx, Ny, X, Y, Nt, T, p, Ux, Uy, D, S, 1, zeros(Nx+2, Ny+2), v);
[m_air,m_sol] = FinalScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,sources,200,rain_matrix,v);
map(m_sol(2:Nx+1,2:Ny+1,1)')