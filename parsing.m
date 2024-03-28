%% Parsing du fichier map.xlsx
T = readtable("map.xlsx");
%T = sortrows(T, "id_grid")
id_s1 = T.emissionSiteID == "C4";
nbr_x = 95;
nbr_y = 62;
lst_polluants2 = ["Benzo_a_Pyr_ne", "x2_3_7_8TCDD", "CadmiumEtCompos_s_exprim_sEnTantQueCd_", "CuivreEtCompos_s_exprim_sEnTantQueCu_", "MercureEtCompos_s_exprim_sEnTantQueHg_", "PlombEtCompos_s_exprim_sEnTantQuePb_", "ZincEtCompos_s_exprim_sEnTantQueZn_"]
lst_polluants = ["Glyphosate360G_L_L_hectare_" "Oxamyl100G_kg_kg_hectare_" "Imazamox17_5G_L" "Rimsulfuron25_0__m_m__kg_hectare_"]
lst_infos = ["id_grid" lst_polluants]
id_sm = (T{:, lst_polluants(1)} > 0) | (T{:, lst_polluants(2)} > 0) | (T{:, lst_polluants(3)} > 0) | (T{:, lst_polluants(4)} > 0)
rep2 = T(id_sm, :)
sources = zeros(nbr_x, nbr_y, length(lst_polluants));
rep = T{id_s1, lst_infos};
taille = size(rep);
nbr_sources = taille(1)
for i=1:nbr_sources
    id = rep(i, 1)
    x = floor((rep(i, 1)-1)/nbr_y) + 1
    y = mod(rep(i, 1)-1 , nbr_y) + 1
    sources(x, y, :) = rep(i, 2:end);
end
return
endroit_ile = (T.cellType == "island");
T.ratio_air_urbain =  T.urbanSoilArea_km_ ./ T.cellTotalArea_km_;
ratio_air = zeros(nbr_x, nbr_y, 1);
size(ratio_air)
for i=1:length(T.id_grid)
    id = T{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1 , nbr_y)+1;
    ratio_air(x, y) = T{id, "ratio_air_urbain"};
end
return
Nt = 8 * 365;
rain_matrix = zeros(nbr_x, nbr_y);
for i=1:length(T.id_grid)
    id = T{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1 , nbr_y)+1;
    rain_matrix(x, y) = T{id, "precipitation_mm_year"};
end
rain_matrix(:, :)
% ratio_air
% T(id_s1, :)
%T{idx, "id_grid"} = 100000000
% Longitude = X, Latitude = Y
%heatmap(T, "cellCentroidLongitude__", "cellCentroidLatitude__", "ColorVariable","id_grid");
%heatmap(T, "cellCentroidLongitude__", "cellCentroidLatitude__", "ColorVariable","precipitation_mm_year")

