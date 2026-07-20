clc; clear; close all;

imageFolder = 'testimages';
imageFiles = dir(fullfile(imageFolder, '*.png'));
numImages = min(3, length(imageFiles));

PSNR_gauss = zeros(1, numImages);
PSNR_med   = zeros(1, numImages);
PSNR_wave  = zeros(1, numImages);
PSNR_nlm   = zeros(1, numImages);

MSE_gauss = zeros(1, numImages);
MSE_med   = zeros(1, numImages);
MSE_wave  = zeros(1, numImages);
MSE_nlm   = zeros(1, numImages);clc; clear; close all;

imageFolder = 'testimages';
imageFiles = dir(fullfile(imageFolder, '*.png'));
numImages = min(3, length(imageFiles));

PSNR_gauss = zeros(1, numImages);
PSNR_med   = zeros(1, numImages);
PSNR_wave  = zeros(1, numImages);
PSNR_nlm   = zeros(1, numImages);

MSE_gauss = zeros(1, numImages);
MSE_med   = zeros(1, numImages);
MSE_wave  = zeros(1, numImages);
MSE_nlm   = zeros(1, numImages);

for k = 1:numImages

    fname = imageFiles(k).name;
    shortName = erase(fname, '.png');
    outFolder = fullfile('outputs', shortName + "_outputs");
    if ~exist(outFolder, 'dir'); mkdir(outFolder); end

    I_orig = im2double(imread(fullfile(imageFolder, fname)));
    if size(I_orig,3)==3; I_orig = rgb2gray(I_orig); end
    I_noisy = I_orig;

    % Gaussian
    h = fspecial('gaussian',[3 3],0.8);
    I_gauss = imsharpen(imfilter(I_noisy,h,'replicate'),'Radius',1.5,'Amount',1.2);

    % Median
    I_med = imsharpen(medfilt2(I_noisy,[3 3]),'Radius',1.5,'Amount',1.2);

    % Wavelet
    I_wave = wdenoise2(I_noisy,2,'Wavelet','sym4','DenoisingMethod','Bayes');
    I_wave = imsharpen(I_wave,'Radius',1.2,'Amount',1.1);

    % NLM
    I_nlm = imsharpen(imnlmfilt(I_noisy),'Radius',1.2,'Amount',1.1);

    % Metrics
    filters = {I_gauss, I_med, I_wave, I_nlm};
    for i = 1:4
        I_filt = filters{i};
        mseVal = immse(I_filt, I_orig);
        psnrVal = psnr(I_filt, I_orig);

        switch i
            case 1, MSE_gauss(k)=mseVal; PSNR_gauss(k)=psnrVal;
            case 2, MSE_med(k)=mseVal;   PSNR_med(k)=psnrVal;
            case 3, MSE_wave(k)=mseVal;  PSNR_wave(k)=psnrVal;
            case 4, MSE_nlm(k)=mseVal;   PSNR_nlm(k)=psnrVal;
        end
    end

    % Save comparison image only
    fig = figure('Visible','off');
    subplot(2,3,1); imshow(I_orig, []);  title('Original');
    subplot(2,3,2); imshow(I_gauss, []); title('Gaussian');
    subplot(2,3,3); imshow(I_med, []);   title('Median');
    subplot(2,3,4); imshow(I_wave, []);  title('Wavelet');
    subplot(2,3,5); imshow(I_nlm, []);   title('NLM');
    subplot(2,3,6); imshow(abs(I_nlm - I_orig), []); title('Difference');
    saveas(fig, fullfile(outFolder, 'comparison.png'));
    close(fig);

end

% Overall PSNR figure
psnrFig = figure('Visible','off');
bar([PSNR_gauss; PSNR_med; PSNR_wave; PSNR_nlm]');
xlabel('Image'); ylabel('PSNR (dB)');
legend('Gaussian','Median','Wavelet','NLM');
title('PSNR Comparison');
saveas(psnrFig, fullfile('outputs','overall_psnr.png'));
close(psnrFig);

% Overall MSE figure
mseFig = figure('Visible','off');
bar([MSE_gauss; MSE_med; MSE_wave; MSE_nlm]');
xlabel('Image'); ylabel('MSE');
legend('Gaussian','Median','Wavelet','NLM');
title('MSE Comparison');
saveas(mseFig, fullfile('outputs','overall_mse.png'));
close(mseFig);

% Summary table display only
T = table((1:numImages)', PSNR_gauss', PSNR_med', PSNR_wave', PSNR_nlm', ...
    MSE_gauss', MSE_med', MSE_wave', MSE_nlm', ...
    'VariableNames', {'Image','PSNR_Gauss','PSNR_Med','PSNR_Wave','PSNR_NLM','MSE_Gauss','MSE_Med','MSE_Wave','MSE_NLM'});

disp(T);


for k = 1:numImages

    fname = imageFiles(k).name;
    shortName = erase(fname, '.png');
    outFolder = fullfile('outputs', shortName + "_outputs");
    if ~exist(outFolder, 'dir'); mkdir(outFolder); end

    I_orig = im2double(imread(fullfile(imageFolder, fname)));
    if size(I_orig,3)==3; I_orig = rgb2gray(I_orig); end
    I_noisy = I_orig;

    % Gaussian
    h = fspecial('gaussian',[3 3],0.8);
    I_gauss = imsharpen(imfilter(I_noisy,h,'replicate'),'Radius',1.5,'Amount',1.2);

    % Median
    I_med = imsharpen(medfilt2(I_noisy,[3 3]),'Radius',1.5,'Amount',1.2);

    % Wavelet
    I_wave = wdenoise2(I_noisy,2,'Wavelet','sym4','DenoisingMethod','Bayes');
    I_wave = imsharpen(I_wave,'Radius',1.2,'Amount',1.1);

    % NLM
    I_nlm = imsharpen(imnlmfilt(I_noisy),'Radius',1.2,'Amount',1.1);

    % Metrics
    filters = {I_gauss, I_med, I_wave, I_nlm};
    for i = 1:4
        I_filt = filters{i};
        mseVal = immse(I_filt, I_orig);
        psnrVal = psnr(I_filt, I_orig);

        switch i
            case 1, MSE_gauss(k)=mseVal; PSNR_gauss(k)=psnrVal;
            case 2, MSE_med(k)=mseVal;   PSNR_med(k)=psnrVal;
            case 3, MSE_wave(k)=mseVal;  PSNR_wave(k)=psnrVal;
            case 4, MSE_nlm(k)=mseVal;   PSNR_nlm(k)=psnrVal;
        end
    end

    % Save individual outputs
    imwrite(I_orig, fullfile(outFolder, 'original.png'));
    imwrite(I_gauss, fullfile(outFolder, 'gaussian.png'));
    imwrite(I_med, fullfile(outFolder, 'median.png'));
    imwrite(I_wave, fullfile(outFolder, 'wavelet.png'));
    imwrite(I_nlm, fullfile(outFolder, 'nlm.png'));

    diffMap = abs(I_nlm - I_orig);
    imwrite(mat2gray(diffMap), fullfile(outFolder, 'difference_map.png'));

    % Save comparison figure
    fig = figure('Visible','off');
    subplot(2,3,1); imshow(I_orig, []);  title('Original');
    subplot(2,3,2); imshow(I_gauss, []); title('Gaussian');
    subplot(2,3,3); imshow(I_med, []);   title('Median');
    subplot(2,3,4); imshow(I_wave, []);  title('Wavelet');
    subplot(2,3,5); imshow(I_nlm, []);   title('NLM');
    subplot(2,3,6); imshow(diffMap, []); title('Difference');
    saveas(fig, fullfile(outFolder, 'comparison.png'));
    close(fig);

    % Save metrics text file
    fileID = fopen(fullfile(outFolder, 'metrics.txt'), 'w');
    fprintf(fileID, "Image: %s\n\n", fname);
    fprintf(fileID, "Gaussian  PSNR: %.4f  MSE: %.6f\n", PSNR_gauss(k), MSE_gauss(k));
    fprintf(fileID, "Median    PSNR: %.4f  MSE: %.6f\n", PSNR_med(k),  MSE_med(k));
    fprintf(fileID, "Wavelet   PSNR: %.4f  MSE: %.6f\n", PSNR_wave(k), MSE_wave(k));
    fprintf(fileID, "NLM       PSNR: %.4f  MSE: %.6f\n", PSNR_nlm(k),  MSE_nlm(k));
    fclose(fileID);

end

% Overall PSNR
figure;
bar([PSNR_gauss; PSNR_med; PSNR_wave; PSNR_nlm]');
xlabel('Image'); ylabel('PSNR (dB)');
legend('Gaussian','Median','Wavelet','NLM');
title('PSNR Comparison');

% Overall MSE
figure;
bar([MSE_gauss; MSE_med; MSE_wave; MSE_nlm]');
xlabel('Image'); ylabel('MSE');
legend('Gaussian','Median','Wavelet','NLM');
title('MSE Comparison');

% Summary table
T = table((1:numImages)', PSNR_gauss', PSNR_med', PSNR_wave', PSNR_nlm', ...
    MSE_gauss', MSE_med', MSE_wave', MSE_nlm', ...
    'VariableNames', {'Image','PSNR_Gauss','PSNR_Med','PSNR_Wave','PSNR_NLM','MSE_Gauss','MSE_Med','MSE_Wave','MSE_NLM'});

disp(T);
