%% Parsing des données de map.xslx

T = readtable("map_phase2_source.xlsx");
lst_polluants = ["x2_3_7_8TCDD" "Benz_ne" "Chlore" "ChromeEtCompos_s_exprim_sEnTantQueCr_" "Compos_sOrganiquesVolatilsNonM_thaniques_COVNM_" "CuivreEtCompos_s_exprim_sEnTantQueCu_" "FluorEtCompos_sInorganiques_enTantQueHF_" "FluorEtSesCompos_s_F_" "HydrocarburesAromatiquesPolycycliques_HAP_" "MercureEtCompos_s_exprim_sEnTantQueHg_" "NickelEtCompos_s_exprim_sEnTantQueNi_" "Particules_PM10_" "ZincEtCompos_s_exprim_sEnTantQueZn_"];
lst_herbicides = ["Oxamyl100G_kg_kg_hectare_" "Glyphosate360G_L_L_hectare_"];
lst_nocifs = [lst_herbicides lst_polluants];
lst_infos = ["id_grid" lst_herbicides lst_polluants];
nbr_x = 95;
nbr_y = 62;
sources = zeros(nbr_x, nbr_y, length(lst_nocifs));
for i=1:length(T.id_grid)
    id = T{i, "id_grid"};
    surface = T{i, "agriculturalSoilArea_km_"};
    if surface == 0
        continue
    end
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1, nbr_y)+1;
    sources(x, y, :) = [(T{i, lst_herbicides} * surface) T{i, lst_polluants}];
end


T_full = readtable("map_phase2_correc_precipit_temp.xlsx");
rain_matrix = zeros(nbr_x, nbr_y);
for i=1:length(T_full.id_grid)
    id = T_full{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1 , nbr_y)+1;
    rain_matrix(x, y) = T_full{i, "precipitation_mm_year"};
end