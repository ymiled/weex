function c=ToySchemeC4(Nx,Ny,Nt,T,c0,Ux,Uy,D)
    dx=1/(Nx+1);
    dy=1/(Ny+1);
    dt=T/Nt;
    c=zeros(Nx+2,Ny+2);
    c=c0; %On initialise avec les conditions initiales.

    figure()
 

    %Resolution numérique avec Diffusion et convection, et vitesse Ux,Uy (vent)
    for n=1:Nt
        laplacien = (c(3:Nx+2,2:Ny+1) + c(1:Nx,2:Ny+1) + c(2:Nx+1,3:Ny+2) + c(2:Nx+1,1:Ny) - 4 * c(2:Nx+1,2:Ny+1))/ (dx * dy);
        derivee_x = (c(3:Nx+2,2:Ny+1) - c(1:Nx,2:Ny+1)) / (2*dx);
        derivee_y = (c(2:Nx+1,3:Ny+2)-c(2:Nx+1,1:Ny)) / (2*dy);

        c(2:Nx+1,2:Ny+1) = max(0, c(2:Nx+1,2:Ny+1) + dt * D * laplacien - dt * Ux(2:Nx+1,2:Ny+1,n) .* derivee_x - dt * Uy(2:Nx+1,2:Ny+1,n) .* derivee_y);

        heatmap(c')
        pause(0.01)

    end
end



