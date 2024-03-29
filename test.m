Nx = 93;
Ny = 60;
Nt = 248;
Tmps = Nt*3*3600;
p = 1;
X = 4000;
Y = 2610;
a = load('vent_1_an.mat');
Ux = a.Ux;
Uy = a.Uy;
D = 0.1;



v = ones(p)*(5e-2);
%[m_air,m_sol] = FinalScheme(Nx, Ny, X, Y, Nt, T, p, Ux, Uy, D, S, 1, zeros(Nx+2, Ny+2), v);
[m_air,m_sol] = FinalScheme(Nx,Ny,X,Y,Nt,Tmps,p,Ux,Uy,D,sources,200,rain_matrix,v,solubilite_polluants);
map(m_sol(2:Nx+1,2:Ny+1,1)');