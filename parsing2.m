%% Parsing des données de map.xslx
opts = detectImportOptions("map_phase2_correc_precipit_temp.xlsx");
opts = setvartype(opts, "EmissionSiteDescription", "string");
T = readtable("map_phase2_correc_precipit_temp.xlsx", opts)
tcdd = "x2_3_7_8TCDD" 
lst_polluants = ["Benz_ne" "Chlore" "ChromeEtCompos_s_exprim_sEnTantQueCr_" "Compos_sOrganiquesVolatilsNonM_thaniques_COVNM_" "CuivreEtCompos_s_exprim_sEnTantQueCu_" "FluorEtCompos_sInorganiques_enTantQueHF_" "FluorEtSesCompos_s_F_" "HydrocarburesAromatiquesPolycycliques_HAP_" "MercureEtCompos_s_exprim_sEnTantQueHg_" "NickelEtCompos_s_exprim_sEnTantQueNi_" "Particules_PM10_" "ZincEtCompos_s_exprim_sEnTantQueZn_"];
lst_herbicides = ["Oxamyl100G_kg_kg_hectare_" "Glyphosate360G_L_L_hectare_"];
lst_nocifs = [tcdd lst_herbicides lst_polluants];
lst_infos = ["id_grid" lst_herbicides lst_polluants];
nbr_x = 95;
nbr_y = 62;
lst_sites = ["VYDATE 10GMaïs fourrageHerbicide2090075" "Agriculture sur brûlis" "AAT GLY360LaitueHerbicide2110067" "AAT GLY360BléHerbicide2110067" "VYDATE 10GcarotteHerbicide2090075" "VYDATE 10GMaïs grainHerbicide2090075" "Centrale énergétique à charbon et à biomasse" "Fabrication d'aliments pour animaux de ferme"]
sources = zeros(nbr_x, nbr_y, length(lst_nocifs));
for i=1:length(T.id_grid)
    if any(T{i, "EmissionSiteDescription"} == lst_sites(:))
    surface = T{i, "agriculturalSoilArea_km_"};
    if surface == 0
        continue
    end
    id = T{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1, nbr_y)+1;
    sources(x, y, :) = [(T{i, tcdd}*surface) (T{i, lst_herbicides} * surface * 10000) T{i, lst_polluants}];
    end
end

T_full = readtable("map_phase2_correc_precipit_temp.xlsx");
rain_matrix = zeros(nbr_x, nbr_y);
for i=1:length(T_full.id_grid)
    id = T_full{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1 , nbr_y)+1;
    rain_matrix(x, y) = T_full{i, "precipitation_mm_year"};
end