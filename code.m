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


Nx = 95;
Ny = 62;
Nt = 248;
T = 2;
c0 = zeros(Nx, Ny) + 1*eye(Nx, Ny);
%Ux = zeros(Nx, Ny,Nt); % Composante x de la vitesse du vent
%Uy = ones(Nx, Ny,Nt); % Composante y de la vitesse du vent
D = 0; % Coefficient de diffusion 


% Appel de la fonction
c = ToySchemeC4(Nx, Ny, Nt, T, c0, Ux, Uy, D)

