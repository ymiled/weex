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
Nx=95;
Ny=62;
p=1
tau=0.05
D=0.1
S=zeros(Nx,Ny,zeros);


Nx = 93;
Ny = 59;
Nt = 248;
T = 2;
c0 = zeros(Nx+2, Ny+2) + 10*eye(Nx+2, Ny+2);
c0(1, 1) = 0;
c0(Nx+2, Nx+2) = 0;

%Ux = zeros(Nx, Ny,Nt); % Composante x de la vitesse du vent
%Uy = ones(Nx, Ny,Nt); % Composante y de la vitesse du vent
D = 0.1; % Coefficient de diffusion 


% Appel de la fonction
c = ToySchemeC4(Nx, Ny, Nt, T, c0, Ux, Uy, D)

