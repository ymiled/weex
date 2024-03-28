function [m_air,m_sol] = FinalScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,S)
    dx=X/Nx; %Avec Nx = 95 et Ny = 62
    dy=Y/Ny;
    dt=T/Nt;
    m_air=zeros(Nx+2,Ny+2,p);
    m_sol=zeros(Nx+2,Ny+2,p); %Les masses aux bords restent nulles
    for j=1:p
        figure(j)
        for n=1:Nt
                laplacien = (m_air(3:Nx+2,2:Ny+1,j) +m_air(1:Nx,2:Ny+1,j) +m_air(2:Nx+1,3:Ny+2,j) +m_air(2:Nx+1,1:Ny,j) - 4 *m_air(2:Nx+1,2:Ny+1,j)) / (dx * dy);
                derivee_x = (m_air(3:Nx+2,2:Ny+1,j) -m_air(1:Nx,2:Ny+1,j)) / (2*dx);
                derivee_y = (m_air(2:Nx+1,3:Ny+2,j) -m_air(2:Nx+1,1:Ny,j)) / (2*dy);


                m_depot = zeros(Nx,Ny);
                m_sol(2:Nx+1,2:Ny+1,j)=m_sol(2:Nx+1,2:Ny+1,j)+m_depot;
                m_air(2:Nx+1,2:Ny+1,j)=max(0,m_air(2:Nx+1,2:Ny+1,j)+dt*(D*laplacien-Ux(:,:,n).*derivee_x - Uy(:,:,n).*derivee_y+S(:,:,j) - m_depot));
            
                heatmap(m_air(:,:,j)');
                pause(0.01);
        end
    end
end