function c=ToySchemeC4(Nx,Ny,Nt,T,c0,Ux,Uy,D)
    dx=1/(Nx+1);
    dy=1/(Ny+1);
    dt=T/Nt;
    c=zeros(Nx+2,Ny+2);
    c(2:Nx+1,2:Ny+1)=c0; %On initialise avec les conditions initiales.
    %D le coeff de diffusion.

    %Resolution numérique avec Diffusion et convection, et vitesse Ux,Uy (vent)
    figure()
    for n=1:Nt
        c(2:Nx+1,2:Ny+1)=c(2:Nx+1,2:Ny+1) + dt*D*(c(3:Nx+2,2:Ny+1)+c(1:Nx,2:Ny+1)-2*c(2:Nx+1,2:Ny+1))/dx^2 + dt*D*(c(2:Nx+1,3:Ny+2)+c(2:Nx+1,1:Ny)-2*c(2:Nx+1,2:Ny+1))/dy^2- dt*Uy(:,:,n).*(c(3:Nx+2,2:Ny+1)-c(1:Nx,2:Ny+1))/(2*dx) - dt*Ux(:,:,n).*(c(2:Nx+1,3:Ny+2)-c(2:Nx+1,1:Ny))/(2*dy);
        heatmap(c);
        hold on;
        pause(0.01);
    end
end



