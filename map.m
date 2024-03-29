picture = imread("map.png");
imshow(picture)
hold on

w=width(picture);
h=height(picture);
z = rand(96,62);
overlay = imagesc([w/190 w-w/124],[h/124 h-h/124], z); % the x/y values are the centers of the first/last box
colormap turbo;
colorbar off
set(overlay, 'AlphaData', .2);