clear all; clc;
glcm_data = [];
for k = 1:350
    % Create an image filename, and read it in to a variable called imageData.
    jpgFileName = strcat(sprintf('%.3d', k), '.jpg');
    if exist(jpgFileName, 'file')
        I = imread(jpgFileName);
        I = imresize(I,1);
        I = rgb2gray(I);
        glcm = graycomatrix(I,'Offset',[0 1]);
        stats = graycoprops(glcm, 'Correlation Homogeneity Contrast Energy');
        glcm_data = [glcm_data; stats.Correlation stats.Homogeneity stats.Contrast stats.Energy];
        fprintf('File %s has been read.\n', jpgFileName);
    else
        fprintf('File %s does not exist.\n', jpgFileName);
    end
end
save('imread_glcm.mat','glcm_data')
Standarded_data = MinAbsScale(glcm_data);





