Nx=95;
Ny=62;
Nt=248;
T=3;
p=1;
X=100;
Y=100;
a=load('vent_1_mois.mat');
Ux=10*a.Ux;
Uy=10*a.Uy;
D=0.1;
S=zeros(Nx,Ny,p);
S((Nx+1)/2,Ny/2,1)=10;



FinalScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,S)