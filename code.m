close all;
a = load("vent_1_mois.mat")


% Load the image
image = imread('map.png');

% Display the image
%imshow(image);

Ux = a.Ux;
Uy = a.Uy;
longitude = a.longitude;
latitude = a.latitude;

%
% for t=1:248
 %   quiver(Ux(:, :, t), Uy(:, :, t))
%end

Nx = 10;
Ny = 10;
Nt = 200;
T = 2;
c0 = zeros(Nx, Ny) + 1*eye(Nx, Ny);
Ux = zeros(Nx, Ny,Nt); % Composante x de la vitesse du vent (peut être modifié selon votre cas)
Uy = ones(Nx, Ny,Nt); % Composante y de la vitesse du vent (peut être modifié selon votre cas)
D = 0.1; % Coefficient de diffusion (peut être modifié selon votre cas)


%quiver(Ux(:, :, 1), Uy(:, :, 1))
test = ones(Nx, Ny);
for i = 1: Ny
    test(i, Ny) = 0;
end
%heatmap(test)
% Appel de la fonction
c = ToySchemeC4(Nx, Ny, Nt, T, c0, Ux, Uy, D)

