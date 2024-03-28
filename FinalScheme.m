function [m_air,m_sol] = FinalScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,S,H,Hm,v)
    dx = X/Nx; %Avec Nx = 95 et Ny = 62
    dy = Y/Ny;
    dt = T/Nt;
    m_air = zeros(Nx+2, Ny+2, p);
    m_sol = zeros(Nx+2, Ny+2, p); %Les masses aux bords restent nulles
    for j=1:p
        figure(j)
        for n=1:Nt    
            for x=2: Nx+1
                for y=2:Ny+1
                    laplacien = (m_air(x+1, y, j) + m_air(x-1, y, j) + m_air(x, y+1, j) + m_air(x, y-1, j) - 4 * m_air(x, y, j)) / (dx * dy);
                
                    if Ux(x, y, n) > 0
                        derivee_x = (m_air(x, y) - m_air(x-1, y)) / dx;
                    else
                        derivee_x = (m_air(x+1, y) - m_air(x, y)) / dx;
                    end
                    if Uy(x, y, n) > 0
                        derivee_y = (m_air(x, y) - m_air(x, y-1)) / dy;
                    else
                        derivee_y = (m_air(x, y+1) - m_air(x, y)) / dy;

                    m_depot = (Hm(x, y)/dt + v(j)) .* m_air(x, y, j) * (dt/H);
                    m_sol(x, y, j) = m_sol(x, y, j) + m_depot;
                    m_air(x, y, j) = (m_air(x, y, j) + dt * (D * laplacien - Ux(x, y, n) .* derivee_x - Uy(x, y, n) .* derivee_y + S(x, y, j) - m_depot));
                
    
                end
            end  
            heatmap(m_air(:, :, j)');
            pause(0.01);
                
        end
    end
end