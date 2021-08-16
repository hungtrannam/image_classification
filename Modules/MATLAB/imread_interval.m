function [interval_data] = imread_interval(image_folder)
filenames = dir(fullfile(image_folder, '*.png'));  % read all images with specified extention, its jpg in our case
total_images = numel(filenames);    % count total number of photos present in that folder

interval_data = [];

for n = 1:total_images
    full_name= fullfile(image_folder, filenames(n).name);         % it will specify images names with full path and extension
    imageData = imread(full_name);                 % Read images
    %imageData = rgb2gray(imageData);
    I = imresize(imageData,1);
    interval = graycomatrix(I, 'Offset', [0 1]);
    stats = GLCM_Features1(interval, 0);
    interval_data = [interval_data; stats.kq];  
end
end
