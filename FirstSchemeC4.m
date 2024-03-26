function c = FirstScheme(N,X,Y,Nt,T,c0,Ux,Uy,D)
    dx=X/N;
    dy=Y/N; %On garde une grille de taille carré avec des cases rectangles
    dt=T/Nt;
    c=c0; %On initialise souvent à zeros(N+2,N+2), on considère que le milieu est pas pollué.
    %Conditions aux bords ? On souhaite que la pollution s'échappe par les bords du carré.
    %On considère que la pollution est nulle en dehors du carré.
    %Ainsi les condtions limites sont c=0 sur les bords du carré. 

    for i=1:Nt
        laplacien = (c(3:N+2,2:N+1) + c(1:N,2:N+1) + c(2:N+1,3:N+2) + c(2:N+1,1:N) - 4 * c(2:N+1,2:N+1))/ (dx * dy);
        derivee_x = (c(3:N+2,2:N+1) - c(1:N,2:N+1)) / (2*dx);
        derivee_y = (c(2:N+1,3:N+2)-c(2:N+1,1:N)) / (2*dy);
        c(2:N+1,2:N+1) = c(2:N+1,2:N+1) + dt * (D * laplacien - Ux * derivee_x - Uy * derivee_y);
        
    end