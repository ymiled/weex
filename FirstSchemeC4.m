function m = FirstSchemeC4(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,S,tau)
    dx = X/Nx;
    dy = Y/Ny;
    dt=T/Nt;
    m=zeros(p,Nx+2,Ny+2); 
    %Conditions aux bords => m(x,y,t) = 0 aux bords
    %tau c'est le temps caractéristique de chaque polluant.
    for i=1:Nt %On loop car on a seuleument besoin de la concentration finale
           
        j = 1:p; %Pour chaque polluant, indicé par j
        
        laplacien = (c(j,3:N+2,2:N+1) + m(j,1:N,2:N+1) + m(j,2:N+1,3:N+2) + m(j,2:N+1,1:N) - 4 * m(j,2:N+1,2:N+1)) / (dx * dy);
        
        derivee_x = (c(j,3:N+2,2:N+1) - m(j,1:N,2:N+1)) / (2*dx);
        derivee_y = (c(j,2:N+1,3:N+2) - m(j,2:N+1,1:N)) / (2*dy);
        
        m(j,2:N+1,2:N+1) = m(j,2:N+1,2:N+1).*(1-dt/tau(j)) + dt * (D * laplacien - Ux(:,:,i) .* derivee_x - Uy(:,:,i) .* derivee_y + S(j,:,:,i)/tau(j));

    end