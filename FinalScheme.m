function [m_air,m_sol] = FinalScheme(Nx,Ny,X,Y,Nt,T,p,Ux,Uy,D,S,H,Hm,v, solubilite_polluants)
    dt=T/Nt;
    dx = 1/(Nx+1); %Avec Nx = 95 et Ny = 62
    dy = 1/(Ny+1);
    m_air = zeros(Nx+2, Ny+2, p);
    Hm=Hm/(8*365)/1000; %Conversion en kg/m^2/jour
    S=S/8/365;
    m_sol = zeros(Nx+2, Ny+2, p); %Les masses aux bords restent nulles
    for polluant=1:p
        %figure(polluant)
        for n=1:Nt
            m_air_temp = m_air;
            for x=2:Nx+1
                for y=2:Ny+1
                    laplacien = (m_air(x+1, y, polluant) + m_air(x-1, y, polluant) - 2 * m_air(x, y, polluant)) / dx / dx + (m_air(x, y+1, polluant) + m_air(x, y-1, polluant) - 2 * m_air(x, y, polluant))/ dy / dy;
                    if Ux(x, y, n) > 0
                        derivee_x = (m_air(x, y, polluant) - m_air(x-1, y, polluant)) / dx;
                    else
                        derivee_x = (m_air(x+1, y, polluant) - m_air(x, y, polluant)) / dx;
                    end
                    if Uy(x, y, n) > 0
                        derivee_y = (m_air(x, y, polluant) - m_air(x, y-1, polluant)) / dy;
                    else
                        derivee_y = (m_air(x, y+1, polluant) - m_air(x, y, polluant)) / dy;
                    end
                    m_depot = (solubilite_polluants(polluant) * Hm(x, y) + v(polluant)) * m_air(x, y, polluant) * (dt/H);
                    m_sol(x, y) = m_sol(x, y) + m_depot;
                    m_air_temp(x, y, polluant) = (m_air(x, y, polluant)  - m_depot + dt * (D * laplacien - Ux(x, y, n) * derivee_x - Uy(x, y, n) * derivee_y + S(x, y, polluant)));
        
                end
            end
            m_air = m_air_temp;

            %heatmap(flip(m_air(:, :, polluant))');
            %title(sprintf('Evolution de la concentration du polluant %d', polluant));
            %clim([0 20])
            %pause(0.01);
                
        end
    end
end