pic = imread('sweden.jpg');
% pic = imread('Aerial-photo-heavy-haze.jpg');
[defuzePic,t_map,tmap_ref] = darkChannel(pic);