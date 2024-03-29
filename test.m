Nx = 93;
Ny = 60;
Nt = 248;
Tmps = 1/12;
p = 9;
X = 1520000;
Y = 992000;
a = load('vent_1_mois.mat');
Ux = a.Ux;
Uy = a.Uy;
D = 1e4/16000/16000;


v=zeros(p);
%v = ones(p)*(5e-2);
%[m_air,m_sol] = FinalScheme(Nx, Ny, X, Y, Nt, T, p, Ux, Uy, D, S, 1, zeros(Nx+2, Ny+2), v);
[m_air,m_sol] = FinalScheme(Nx,Ny,X,Y,Nt,Tmps,p,Ux,Uy,D,sources,200,rain_matrix,v,solubilite_polluants);

%map(m_sol(2:Nx+1,2:Ny+1,1)');