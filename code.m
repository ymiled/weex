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


c = FirstSchemeC4(Nx,Ny,longitude,latitude,Nt,T,p,Ux,Uy,D,S,tau);

