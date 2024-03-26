%% Parsing du fichier map.xlsx
T = readtable("map.xlsx");
%T = sortrows(T, "id_grid")
id_s1 = T.emissionSiteID == "C4";
nbr_x = 95;
nbr_y = 62;
lst_pols = ["Benzo_a_Pyr_ne", "x2_3_7_8TCDD", "CadmiumEtCompos_s_exprim_sEnTantQueCd_", "CuivreEtCompos_s_exprim_sEnTantQueCu_", "MercureEtCompos_s_exprim_sEnTantQueHg_", "PlombEtCompos_s_exprim_sEnTantQuePb_", "ZincEtCompos_s_exprim_sEnTantQueZn_"]
lst_infos = ["id_grid" lst_pols]
source = zeros(nbr_x, nbr_y, length(lst_pols));
rep = T{id_s1, lst_infos}
taille = size(rep)
nbr_sources = taille(1)
for i=1:nbr_sources
    id = rep(i, 1)
    x = ceil(rep(i, 1)/nbr_y)
    y = mod(rep(i, 1) , nbr_y)
    source(x, y, :) = rep(i, 2:end);
end
source(:, :, 2)



%T{idx, "id_grid"} = 100000000
% Longitude = X, Latitude = Y
%heatmap(T, "cellCentroidLongitude__", "cellCentroidLatitude__", "ColorVariable","id_grid");
%heatmap(T, "cellCentroidLongitude__", "cellCentroidLatitude__", "ColorVariable","precipitation_mm_year")

