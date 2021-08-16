function [pdf_data] = imread_1d(image_folder)
filenames = dir(fullfile(image_folder, '*.png'));  % read all images with specified extention, its jpg in our case
total_images = numel(filenames);    % count total number of photos present in that folder

pdf_data = [];

for n = 1:total_images
    full_name= fullfile(image_folder, filenames(n).name);         % it will specify images names with full path and extension
    imageData = imread(full_name);                 % Read images
    %imageData = rgb2gray(imageData);
    I = im2double(imageData);
    reshape_data = reshape(I, numel(I), 1);
    ksden_data = ksdensity(reshape_data, 0:.001:1);
    pdf_data = [pdf_data ksden_data'];
end
end
