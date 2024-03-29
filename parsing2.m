%% Parsing des données de map.xslx
opts = detectImportOptions("map_phase2_correc_precipit_temp.xlsx");
opts = setvartype(opts, "EmissionSiteDescription", "string");
T = readtable("map_phase2_correc_precipit_temp.xlsx", opts);
tcdd = "x2_3_7_8TCDD";
lst_polluants = ["ChromeEtCompos_s_exprim_sEnTantQueCr_" "Compos_sOrganiquesVolatilsNonM_thaniques_COVNM_" "HydrocarburesAromatiquesPolycycliques_HAP_" "MercureEtCompos_s_exprim_sEnTantQueHg_" "Particules_PM10_" "ZincEtCompos_s_exprim_sEnTantQueZn_"];
lst_herbicides = ["Oxamyl100G_kg_kg_hectare_" "Glyphosate360G_L_L_hectare_"];
lst_nocifs = [tcdd lst_herbicides lst_polluants];
lst_infos = ["id_grid" lst_herbicides lst_polluants];
nbr_x = 95;
nbr_y = 62;
% lst_sites = ["VYDATE 10GMaïs fourrageHerbicide2090075" "Agriculture sur brûlis" "AAT GLY360LaitueHerbicide2110067" "AAT GLY360BléHerbicide2110067" "VYDATE 10GcarotteHerbicide2090075" "VYDATE 10GMaïs grainHerbicide2090075" "Centrale énergétique à charbon et à biomasse" "Fabrication d'aliments pour animaux de ferme"]
lst_sites_herbicides = ["VYDATE 10GMaïs fourrageHerbicide2090075" "AAT GLY360LaitueHerbicide2110067" "AAT GLY360BléHerbicide2110067" "VYDATE 10GcarotteHerbicide2090075" "VYDATE 10GMaïs grainHerbicide2090075"];
sites_brulis = "Agriculture sur brûlis";
site_fab_alim = "Fabrication d'aliments pour animaux de ferme";
site_centrale_biomasse = "Centrale énergétique à charbon et à biomasse";
sources = zeros(nbr_x, nbr_y, length(lst_nocifs));
surface_driven = [lst_herbicides sites_brulis];
cell_driven = [site_fab_alim site_centrale_biomasse];
for i=1:length(T.id_grid)
    id = T{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1, nbr_y)+1;
    site_description = T{i, "EmissionSiteDescription"};
    surface = T{i, "agriculturalSoilArea_km_"};
    if any(site_description == surface_driven(:))
    if surface == 0
        continue
    end
    sources(x, y, :) = [(T{i, tcdd}*surface) (T{i, lst_herbicides} * surface * 10000) T{i, lst_polluants}];
    elseif any(site_description == cell_driven(:))
     sources(x, y, :) = [(T{i, tcdd}*surface) (T{i, lst_herbicides} * surface * 10000) T{i, lst_polluants}];
    end
end

rain_matrix = zeros(nbr_x, nbr_y);
pop_matrix = zeros(nbr_x, nbr_y);
surfaces_matrix = zeros(nbr_x, nbr_y, 3); %proportion de : 1: air urbain, 2: sol naturel, 3: sol agricole 
for i=1:length(T.id_grid)
    id = T{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1 , nbr_y)+1;
    surface = 49000;
    surfaces_matrix(x, y, 1) = T{i, "urbanSoilArea_km_"} / surface;
    surfaces_matrix(x, y, 2) = T{i, "totalNaturalSoilAreaForest_OtherNaturalSoil_km_"} / surface;
    surfaces_matrix(x, y, 3) = T{i, "agriculturalSoilArea_km_"} / surface;
    rain_matrix(x, y) = T{i, "precipitation_mm_year"};
    pop_matrix(x, y) = T{i, "totalRuralPopulationWithinGridCell_inhabitants"} + T{i, "totalUrbanPopulationWithinGridCell_inhabitants"};
end
lst_impacts_nocifs = arrayfun(@change, lst_nocifs);
reponse_air = zeros(95, 62, length(lst_nocifs));
reponse_sol = zeros(95, 62, length(lst_nocifs));
[nbr_x, nbr_y, n_polluants] = size(reponse_air);

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
            rep(id, 3 + i_pol) = reponse_air(x, y, i_pol) + reponse_sol(x, y, i_pol);
            rep(id, 3 + n_polluants + i_pol) = toxicite(reponse_air(x, y, i_pol), reponse_sol(x, y, i_pol), ...
                pop_matrix(x, y), f_urb, (1-f_urb), surfaces_matrix(x, y, 2), surfaces_matrix(x, y, 3), ...
                pol_matrix(i_pol, 1), pol_matrix(i_pol, 2), pol_matrix(i_pol, 3), pol_matrix(i_pol, 4), ...
                pol_matrix(i_pol, 5));
        end
    end
    rep(id, 4 + 2 * n_polluants) = sum(rep(id, 5:2:2*n_polluants+3));
end

T_reponse=array2table(rep,'VariableNames', ["id_grid" "cellCentroidLatitude__" "cellCentroidLongitude__" lst_nocifs lst_impacts_nocifs "impact"]);
writetable(T_reponse, "Documents/UEs/WEEX_Depol/weex/reponse.csv");
function rep = change(txt)
    rep = "impact_" + txt;
end


%% Equation de toxicité
function tox = toxicite(m_air, m_depot, N_h, f_urb, f_rur, f_nat, f_agr, C_pol, C_a_urb, C_a_rur, C_s_nat, C_s_agr)
    somme_air = f_urb * C_a_urb + f_rur * C_a_rur;
    somme_sol = f_agr * C_s_agr + f_nat * C_s_nat;
    tox = (m_air*somme_air + m_depot * somme_sol) * C_pol * (N_h/10^9);
end