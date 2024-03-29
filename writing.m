%% Écriture des données vers le fichier xlsx
T = readtable("map_phase2_correc_precipit_temp.xlsx");
tcdd = "x2_3_7_8TCDD";
lst_polluants = ["Benz_ne" "Chlore" "ChromeEtCompos_s_exprim_sEnTantQueCr_" "Compos_sOrganiquesVolatilsNonM_thaniques_COVNM_" "CuivreEtCompos_s_exprim_sEnTantQueCu_" "FluorEtCompos_sInorganiques_enTantQueHF_" "FluorEtSesCompos_s_F_" "HydrocarburesAromatiquesPolycycliques_HAP_" "MercureEtCompos_s_exprim_sEnTantQueHg_" "NickelEtCompos_s_exprim_sEnTantQueNi_" "Particules_PM10_" "ZincEtCompos_s_exprim_sEnTantQueZn_"];
lst_herbicides = ["Oxamyl100G_kg_kg_hectare_" "Glyphosate360G_L_L_hectare_"];
lst_impacts_nocifs = arrayfun(@change, lst_nocifs);
reponse_air = zeros(95, 62, length(lst_nocifs));
reponse_sol = zeros(95, 62, length(lst_nocifs));
[nbr_x, nbr_y, n_polluants] = size(reponse_air);


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
            rep(id, 3 + i_pol) = toxicite(reponse_air(x, y, i_pol), reponse_sol(x, y, i_pol), )
            rep(id, 3 + n_polluants + i_pol) = 1;
        end
    end
    rep(id, 4 + 2 * n_polluants) = 2;
end

T_reponse=array2table(rep,'VariableNames', ["id_grid" "cellCentroidLatitude__" "cellCentroidLongitude__" lst_nocifs lst_impacts_nocifs "impact"]);
writetable(T_reponse, "Documents/UEs/WEEX_Depol/weex/reponse.csv");
function rep = change(txt)
    rep = "impact_" + txt;
end


%% Equation de toxicité
function tox = toxicite(m_air, m_depot, N_h, f_urb, f_rur, f_agr, f_nat, C_a_urb, C_a_rur, C_s_agr, C_s_nat)
    somme_air = f_urb * C_a_urb + f_rur * C_a_rur;
    somme_sol = f_agr * C_s_agr + f_nat * C_s_nat;
    tox = (m_air*somme_air + m_depot * somme_sol) * (N_h/10^9);
end