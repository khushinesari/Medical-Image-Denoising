# Denoising of Medical Images 

### Project Description:
Noise Reduction System: Removes noise from MRI or X-ray images using Gaussian, Median, and Wavelet filters to enhance clarity while preserving structural details. Evaluates the performance with PSNR and MSE metrics. This system improves diagnostic image quality and compares denoising effectiveness.
#### Summary - 
Medical images often contain noise and visual inconsistencies that can reduce clarity and affect further analysis. This project implements a denoising pipeline for MRI and X-ray scans using Gaussian, Median, Wavelet and Non-Local Means filters, along with PSNR and MSE evaluation. It also includes a colour correction module that removes unwanted blue tint from coloured MRI images, a process that can be adapted for other specialised applications. All outputs are organised into structured folders, providing a clean and effective workflow for medical image enhancement and preprocessing.

#### Course concepts used - 
1. Image Noise Models: Understanding the types of noise that degrade images.
2. Wavelet Transform: A technique that breaks an image into different levels of detail (frequencies) and scales.
3. Spatial Domain Filtering: Applying filters directly to the image pixels in their spatial layout.
4. Linear Filtering (Gaussian): A filter where the output is a weighted average of input pixels.
5. Non-Linear Filtering (Median): A filter where the output is based on ordering pixel values(finding the median), which is excellent for preserving edges.
6. Wavelet Thresholding: The method of removing noise in the wavelet domain by setting small coefficients(assumed to be noise) to zero.
7. Objective Metrics (PSNR & MSE): Mathematical formulas (Mean Squared Error and Peak Signal-to-Noise Ratio) used to numerically score the difference between a clean original and a denoised image.
#### Additional concepts used -
1. NLM (Non-Local Means): A powerful denoising filter that cleans a pixel by averaging it with other pixels from across the entire image that have a similar-looking neighborhood (or "patch"), which excels at preserving fine textures and sharp edges.
   
#### Dataset - 
https://www.kaggle.com/datasets/dishantpadalia/denoising-brain-tumor

#### Novelty - 
1. Uses multiple denoising filters (Gaussian, Median, Wavelet, NLM) in one system.
2. Adds a colour-correction module for removing MRI blue tint.
3. Preserves fine anatomical details essential for diagnosis.
4. Generates clean, organized output folders for easy workflow.
   
### Contributors:
1. Kamlesh J (PES1UG23EC140)
2. Khushi Nesari (PES1UG23EC147)
3. Medha Venkatesh (PES1UG23EC174)

### Outputs:
* Refer outputs folder 

### References:
1. https://www.geeksforgeeks.org/non-local-means-filter-for-image-denoising/
2. https://www.geeksforgeeks.org/wavelet-transform-in-image-processing/
   
### Limitations:
* Uniform Filtering: Blurs both noise and important details (like tumor edges) together.
* Incorrect Noise Model: Uses generic filters (like Gaussian) instead of filters designed for specific medical noise (like Rician noise).
* 2D Slice Processing: Ignores the valuable 3D data between image slices.
* Inflexible Color-Correction: Only fixes one specific "blue tint" and nothing else.
### Future Work:
* Implement Deep Learning (CNN): Using a U-Net or DnCNN to learn noise patterns for more effective removal.
* Test Advanced Filters: Comparing results against powerful classical filters like BM3D or Anisotropic Diffusion.
* Build Robust Color-Correction: Replacing the simple tint removal with a general-purpose automatic white balancing or histogram-based module.
