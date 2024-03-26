function c = FirstScheme(N,X,Y,Nt,T,c0,Ux,Uy,D)
    dx=X/N;
    dy=Y/N; %On garde une grille de taille carré avec des cases rectangles
    dt=T/Nt;
    c=c0; %On initialise souvent à zeros(N+2,N+2)

    for i=1:Nt
        laplacien = (c(3:Nx+2,2:Ny+1) + c(1:Nx,2:Ny+1) + c(2:Nx+1,3:Ny+2) + c(2:Nx+1,1:Ny) - 4 * c(2:Nx+1,2:Ny+1))/ (dx * dy);

    end