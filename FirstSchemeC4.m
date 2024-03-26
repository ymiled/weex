function c = FirstScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,S,Hm)
    dx = X/Nx;
    dy = Y/Ny;
    dt=T/Nt;
    c=zeros(p,Nx+2,Ny+2); 
    %Conditions aux bords => c(x,y,t) = 0 aux bords

    for i=1:Nt
           
        j = 1:p; %Pour chaque polluant, indicé par j
        
        laplacien = (c(j,3:N+2,2:N+1) + c(j,1:N,2:N+1) + c(j,2:N+1,3:N+2) + c(j,2:N+1,1:N) - 4 * c(j,2:N+1,2:N+1)) / (dx * dy);
        
        derivee_x = (c(j,3:N+2,2:N+1) - c(j,1:N,2:N+1)) / (2*dx);
        derivee_y = (c(j,2:N+1,3:N+2) - c(j,2:N+1,1:N)) / (2*dy);
        
        c(j,2:N+1,2:N+1) = c(j,2:N+1,2:N+1) + dt * (D * laplacien - Ux(:,:,i) .* derivee_x - Uy(:,:,i) .* derivee_y + S(j,:,:,i));

    end