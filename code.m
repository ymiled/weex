clear all;
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

Nx = 10;
Ny = 10;
Nt = 200;
T = 1;
c0 = zeros(Nx+2, Ny+2);
c0(6,6)=1;

Ux = zeros(Nx+2, Ny+2,Nt); % Composante x de la vitesse du vent
Uy = ones(Nx+2, Ny+2,Nt); % Composante y de la vitesse du vent
D = 0.1; % Coefficient de diffusion 


% Appel de la fonction
c = ToySchemeC4(Nx, Ny, Nt, T, c0, Ux, Uy, D);

