function c=ToySchemeC4(Nx,Ny,Nt,T,c0,Ux,Uy,D)
    dx=1/(Nx+1);
    dy=1/(Ny+1);
    dt=T/Nt;
    c=zeros(Nx+2,Ny+2);
    c=c0; %On initialise avec les conditions initiales.
 

    %Resolution numérique avec Diffusion et convection, et vitesse Ux,Uy (vent)
    for n=1:Nt
        for i=2:Nx+2
            for j=2:Ny+2
                laplacien = (c(i+1,j) + c(i-1,j) + c(i,j+1) + c(i, j-1) - 4 * c(i, j))/ (dx * dy);
                derivee_x = (c(i+1, j) - c(i-1,j)) / (2*dx);
                derivee_y = (c(i,j+1)-c(i,j-1)) / (2*dy);
        
                c(i, j) = c(i, j) + dt * D * laplacien - dt * Ux(i,j,n) .* derivee_x - dt * Uy(i,j,n) .* derivee_y;

            end
        end

    end
end



