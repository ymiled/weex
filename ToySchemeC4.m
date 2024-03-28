function c=ToySchemeC4(Nx,Ny,Nt,T,c0,Ux,Uy,D)
    dx=1/(Nx+1);
    dy=1/(Ny+1);
    dt=T/Nt;
    c=zeros(Nx+2,Ny+2);
    c=c0; %On initialise avec les conditions initiales.
 
    figure()
    %Resolution numérique avec Diffusion et convection, et vitesse Ux,Uy (vent)
    for n=1:Nt
        
        for i=2:Nx+1
            for j=2:Ny+1
                laplacien = (c(i+1,j) + c(i-1,j) + c(i,j+1) + c(i, j-1) - 4 * c(i, j))/ (dx * dy);
                if Ux(i,j,n) > 0
                    derivee_x = (c(i, j) - c(i-1,j)) / dx;
                else
                    derivee_x = (c(i+1, j) - c(i,j)) / dx;
                end
                if Uy(i,j,n) > 0
                    derivee_y = (c(i,j) - c(i,j-1)) / dy;
                else
                    derivee_y = (c(i,j+1) - c(i,j)) / dy;
                end
                c(i, j) = c(i, j) + dt * D * laplacien - dt * Ux(i,j,n) .* derivee_x - dt * Uy(i,j,n) .* derivee_y;

            end
        end
        heatmap(c')
        pause(0.01)
    end
end



