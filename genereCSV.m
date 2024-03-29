
lst_impacts_nocifs = arrayfun(@change, lst_nocifs);
%m_air = zeros(95, 62, length(lst_nocifs));
%m_sol = zeros(95, 62, length(lst_nocifs));
[nbr_x, nbr_y, n_polluants] = size(m_air);

% 1CDUH, 2345: % de ce CDUH selon la surface
pol_matrix = [6454 0.07 0.07 0.024 0.22;
    0.00064 0.0026 0.0018 0.0004 0.013;
    0.00005 0.0017 0.0022 0.00034 0.024;
    0.25 0.014 0.011 0.016 0.024;
    0.05 0.05 0.05 0.05 0.05;
    0.4 0.05 0.05 0.05 0.05;
    118.1 0.04 0.04 0.00026 0.82;
    1.1 0.1 0.1 0 0;
    0.21 0.04 0.04 0.001 0.82]
id_max = nbr_x * nbr_y;
rep = zeros(id_max, (3+2*n_polluants + 1));
size(rep)
for x=1:nbr_x
    for y=1:nbr_y
        id = (x-1) * nbr_y + y;
        rep(id, 1) = T{id, "id_grid"};
        rep(id, 2) = T{id, "cellCentroidLongitude__"};
        rep(id, 3) = T{id, "cellCentroidLatitude__"};
        for i_pol=1:n_polluants
            f_urb = surfaces_matrix(x, y, 1);
            rep(id, 3 + i_pol) = m_air(x, y, i_pol) + m_sol(x, y, i_pol);
            rep(id, 3 + n_polluants + i_pol) = toxicite(m_air(x, y, i_pol), m_sol(x, y, i_pol), ...
                pop_matrix(x, y), f_urb, (1-f_urb), surfaces_matrix(x, y, 2), surfaces_matrix(x, y, 3), ...
                pol_matrix(i_pol, 1), pol_matrix(i_pol, 2), pol_matrix(i_pol, 3), pol_matrix(i_pol, 4), ...
                pol_matrix(i_pol, 5));
        end
    end
    rep(id, 4 + 2 * n_polluants) = sum(rep(id, 5:2:2*n_polluants+3));
end

T_reponse=array2table(rep,'VariableNames', ["id_grid" "cellCentroidLatitude__" "cellCentroidLongitude__" lst_nocifs lst_impacts_nocifs "impact"]);
writetable(T_reponse, "/home/moussehugo/Documents/WEEX/weex/reponse.csv");
function rep = change(txt)
    rep = "impact_" + txt;
end


%% Equation de toxicité
function tox = toxicite(m_air, m_depot, N_h, f_urb, f_rur, f_nat, f_agr, C_pol, C_a_urb, C_a_rur, C_s_nat, C_s_agr)
    somme_air = f_urb * C_a_urb + f_rur * C_a_rur;
    somme_sol = f_agr * C_s_agr + f_nat * C_s_nat;
    tox = (m_air*somme_air + m_depot * somme_sol) * C_pol * (N_h/10^9);
end