a = load("vent_1_mois.mat");


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

Nx = 20;
Ny = 20;
Nt = 500;
T = 3;
c0 = zeros(Nx, Ny) + 10*eye(Nx, Ny);
Ux = ones(Nx, Ny,Nt); % Composante x de la vitesse du vent (peut être modifié selon votre cas)
Uy = zeros(Nx, Ny,Nt); % Composante y de la vitesse du vent (peut être modifié selon votre cas)
D = 0; % Coefficient de diffusion (peut être modifié selon votre cas)

% Appel de la fonction
c = ToySchemeC4(Nx, Ny, Nt, T, c0, Ux, Uy, D)