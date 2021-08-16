function [pdf_data] = imread_1d(image_folder)
filenames = dir(fullfile(image_folder, '*.png')); 
total_images = numel(filenames);

pdf_data = [];

for n = 1:total_images
    full_name= fullfile(image_folder, filenames(n).name);
    imageData = imread(full_name);
    %imageData = rgb2gray(imageData);
    I = im2double(imageData);
    reshape_data = reshape(I, numel(I), 1);
    ksden_data = ksdensity(reshape_data, 0:.001:1);
    pdf_data = [pdf_data ksden_data'];
end
end
