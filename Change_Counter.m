%%% CHANGE COUNTER
%{
This MATLAB script takes in an image of coins on a 
black background and outputs the total amount of change

Jairo Huaylinos, 1/23/20
%}

%%% Import image and convert to grayscale
clc;
clear all;
close all;
coins = imread('coins.jpg');
figure(1);
imshow(coins), title 'RGB image';
coinsgray = rgb2gray(coins);
coinsgray = imadjust(coinsgray);
figure(2);
imshow(coinsgray), title 'Grayscale image';

%%% Convert to B&W and fill in holes
coinsbw = im2bw(coinsgray);
figure(3);
imshow(coinsbw), title 'B&W Render';
bwfill = imfill(coinsbw, 'holes');
figure(4);
imshow(bwfill), title 'Fill Holes';

%%% Filter the image
bwclean = bwareaopen(bwfill, 300);
se = strel('disk', 20);
bwclean = imclose(bwclean, se);
bwclean = imfill(bwclean, 'holes');
figure(5);
imshow(bwclean), title 'Filter noise';


%%% Counting the number of coins and the computing their diameters
change = 0.0;

labeled = bwlabel(bwclean);
n = max(max(labeled));
for i=1:n
    pixel_area = sum(labeled(:) == i);
    if(pixel_area >= 320000 && pixel_area <= 330000) change = change + 0.25;
    elseif(pixel_area >= 190000 && pixel_area <= 210000) change = change + 0.01;
    elseif(pixel_area >= 170000 && pixel_area <= 180000) change = change + 0.10;
    elseif(pixel_area >= 240000 && pixel_area <= 260000) change = change + 0.05;
    end
end

msgbox(sprintf("You have $%.2f", change), 'Total Change', 'custom', coins);

