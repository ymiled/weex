%% Parsing des données de map.xslx
opts = detectImportOptions("map_phase2_correc_precipit_temp.xlsx");
opts = setvartype(opts, "EmissionSiteDescription", "string");
T = readtable("map_phase2_correc_precipit_temp.xlsx", opts);
tcdd = "x2_3_7_8TCDD";
lst_polluants = ["ChromeEtCompos_s_exprim_sEnTantQueCr_" "Compos_sOrganiquesVolatilsNonM_thaniques_COVNM_" "HydrocarburesAromatiquesPolycycliques_HAP_" "MercureEtCompos_s_exprim_sEnTantQueHg_" "Particules_PM10_" "ZincEtCompos_s_exprim_sEnTantQueZn_"];
lst_herbicides = ["Oxamyl100G_kg_kg_hectare_" "Glyphosate360G_L_L_hectare_"];
lst_nocifs = [tcdd lst_herbicides lst_polluants];
lst_infos = ["id_grid" lst_herbicides lst_polluants];
solubilite_polluants = [0 1 1 1 0 1 1 1 1];

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
     sources(x, y, :) = [(T{i, tcdd}*surface) (T{i, lst_herbicides} * surface * 10000) T{i, lst_polluants}]
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
