function map(data_matrix)
    % Charger l'image
    picture = imread("map.png");
    imshow(picture)
    hold on

    % Dimensions de l'image
    w = size(picture, 2);
    h = size(picture, 1);

    % Nombre de cases en x et y pour votre overlay
    num_boxes_x = size(data_matrix, 2); % Nombre de cases en largeur
    num_boxes_y = size(data_matrix, 1); % Nombre de cases en hauteur

    % Taille d'une case
    box_width = w / num_boxes_x;
    box_height = h / num_boxes_y;

    % Dessiner l'overlay
    overlay = imagesc([0 w], [0 h], data_matrix); % Utiliser la matrice fournie
    colormap turbo;
    colorbar

    % Définir la transparence de l'overlay
    set(overlay, 'AlphaData', 0.2);

    % Ajuster les axes pour que les cases soient carrées
    axis equal;

    % Ajuster les limites des axes pour correspondre à la taille de l'image
    xlim([0, w]);
    ylim([0, h]);

    % Affichage de la légende
    colorbar;
end