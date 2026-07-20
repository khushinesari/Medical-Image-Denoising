clc; clear; close all;

imgPath = 'colouredbrain1.jpg'; %insert path to img here
I = im2double(imread(imgPath));

[~, fname, ~] = fileparts(imgPath);
outFolder = fullfile('outputs', fname + "_outputs");
if ~exist(outFolder, 'dir'); mkdir(outFolder); end

R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

blueMask = B > (R + G)/2;
suppressAmount = 0.4;

B_clean = B;
B_clean(blueMask) = B_clean(blueMask) * (1 - suppressAmount);

R_clean = R + 0.15 * (B - B_clean);
G_clean = G + 0.10 * (B - B_clean);

I_clean = cat(3, R_clean, G_clean, B_clean);
I_clean = max(min(I_clean,1),0);

% Save cleaned image
imwrite(I_clean, fullfile(outFolder, 'blue_fix.png'));

% Save side-by-side comparison
fig = figure('Visible','off');
subplot(1,2,1); imshow(I); title('Original Image');
subplot(1,2,2); imshow(I_clean); title('Blue Tint Removed');
saveas(fig, fullfile(outFolder, 'blue_fix_comparison.png'));
close(fig);

disp("Blue tint removal outputs saved to: " + outFolder);
