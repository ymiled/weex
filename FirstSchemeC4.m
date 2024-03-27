function [m_air,m_sol] = FirstSchemeC4(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,S,tau)
    dx = X/Nx;
    dy = Y/Ny;
    dt=T/Nt;
    m_air=zeros(p,Nx+2,Ny+2);
    m_sol=zeros(p,Nx+2,Ny+2);
    %Conditions aux bords =>m_air(x,y,t) = 0 aux bords
    %tau c'est le temps caractéristique de chaque polluant.
    for i=1:Nt %On loop car on a seuleument besoin de la concentration finale
           
        j = 1:p; %Pour chaque polluant, indicé par j
        
        laplacien = (m_air(j,3:Nx+2,2:Ny+1) +m_air(j,1:Nx,2:Ny+1) +m_air(j,2:Nx+1,3:Ny+2) +m_air(j,2:Nx+1,1:Ny) - 4 *m_air(j,2:Nx+1,2:Ny+1)) / (dx * dy);
        
        derivee_x = (m_air(j,3:Nx+2,2:Ny+1) -m_air(j,1:Nx,2:Ny+1)) / (2*dx);
        derivee_y = (m_air(j,2:Nx+1,3:Ny+2) -m_air(j,2:Nx+1,1:Ny)) / (2*dy);
        
        %On calcule la m_air déposé..
        depot = zeros(p,Nx+2,Ny+2); %à modifier
        m_sol=m_sol+depot;
        m_air(j,2:Nx+1,2:Ny+1) =m_air(j,2:Nx+1,2:Ny+1).*(1-dt/tau(j)) + dt * (D * laplacien - Ux(2:Nx+1,2:Ny+1,i) .* derivee_x - Uy(2:Nx+1,2:Ny+1,i) .* derivee_y + S(j,2:Nx+1,2:Ny+1,i) - depot(j,2:Nx+1,2:Ny+1));
    end

end