







function c=ToySchemeXY(Nx,Ny,Nt,T,c0,Ux,Uy,D)
    dx=1/(Nx+1);
    dy=1/(Ny+1);
    dt=T/Nt;
    c=zeros(Nx+2,Ny+2);
    c(2:Nx+1,2:Ny+1)=c0; %On initialise avec les conditions initiales.



