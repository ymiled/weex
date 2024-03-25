a = load("vent_1_mois.mat");


% Load the image
image = imread('map.png');

% Display the image
imshow(image);

Ux = a.Ux;
Uy = a.Uy;
longitude = a.longitude;
latitude = a.lattitude;

for t=1:248
    quiver(Ux(:, :, t), Uy(:, :, t))
end
