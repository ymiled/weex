%% Coloration de la map
opts = detectImportOptions("map_phase2_correc_precipit_temp.xlsx");
opts = setvartype(opts, "EmissionSiteDescription", "string");
T = readtable("map_phase2_correc_precipit_temp.xlsx", opts);
nbr_x = 95;
nbr_y = 62;
lst_sites_herbicides = ["VYDATE 10GMaïs fourrageHerbicide2090075" "AAT GLY360LaitueHerbicide2110067" "AAT GLY360BléHerbicide2110067" "VYDATE 10GcarotteHerbicide2090075" "VYDATE 10GMaïs grainHerbicide2090075"];
sites_brulis = "Agriculture sur brûlis";
site_fab_alim = "Fabrication d'aliments pour animaux de ferme";
site_centrale_biomasse = "Centrale énergétique à charbon et à biomasse";

color_matrix = zeros (nbr_x, nbr_y, 3);
for i=1:length(T.id_grid)
    id = T{i, "id_grid"};
    x = floor((id-1)/nbr_y)+1;
    y = mod(id-1, nbr_y) + 1;
    surface = T{i, "agriculturalSoilArea_km_"};
    if any(T{i, "EmissionSiteDescription"} == lst_sites_herbicides(:))
    if surface == 0
        continue
    end
        color_matrix(x, y, :) = [0, 1, 0];
    elseif T{i, "EmissionSiteDescription"} == sites_brulis
    if surface == 0
        continue
    end
        color_matrix(x, y, :) = [0, 1, 1];
    elseif T{i, "EmissionSiteDescription"} == site_fab_alim
        color_matrix(x, y, :) = [1, 1, 0];
        a = [x, y]
    elseif T{i, "EmissionSiteDescription"} == site_centrale_biomasse
        color_matrix(x, y, :) = [0, 0, 1];
        b = [x, y]
    else
        color_matrix(x, y, :) = [1, 1, 1];
    end
end

picture = imread("map.png");
imshow(picture)
hold on

w=width(picture);
h=height(picture);
z = rand(96,62);
overlay = imagesc([w/190 w-w/124],[h/124 h-h/124], permute(color_matrix, [2 1 3])); % the x/y values are the centers of the first/last box
colormap turbo;
colorbar off
set(overlay, 'AlphaData', 0.5);
