% pic = imread('sweden.jpg');
pic = imread('Aerial-photo-heavy-haze.jpg');
[defuzePic,tmap,tmap_ref] = darkChannel(pic);
