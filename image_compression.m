close all;
clear all;
%Calculating the dct basis using calc_basis function
%for just visualization
basis = calc_basis(8);
figure();
title('64 dct basis');
for i = 1:64
        subplot(8,8,i)
        imshow(basis(:,:,i));
end

%loading file to be compressed
filename = 'test.png';
image = imread(filename);

%converting into gray
image_gray = rgb2gray(image);
imwrite(image_gray, 'test_gray.tif')


%compressing the file using jpeg image compression algorithm
%resizing it
size = size(image_gray);
resize_size = ceil(min(size(1),size(2))/8)*8;
image_gray_rs = imresize(image_gray, [resize_size, resize_size]);
%compressing it
[reconst_image, no_of_zeros, error_image, error_coeff] = block_dct2_quantize(image_gray_rs);
%resizing the file back to its original size
reconst_image_re = imresize(reconst_image, [size(1), size(2)]);


%writing the compressed file to 'comp_image.tif'
imwrite(reconst_image_re, 'comp_image.tif')

%displaying original and compressed file
figure();
imshow(image_gray_rs)
title('Original Image')
figure();
imshow(reconst_image)
title('Compressed Image')
