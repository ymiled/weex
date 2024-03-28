Nx=95;
Ny=62;
Nt=248;
T=0.5;
p=1;
X=100;
Y=100;
a=load('vent_1_mois.mat');
Ux=100*a.Ux;
Uy=100*a.Uy;
D=0;
S=zeros(Nx,Ny,p);
S((Nx+1)/2,Ny/2,1)=10;


v=ones(p);
FinalScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,sources,rain_matrix,200,v);