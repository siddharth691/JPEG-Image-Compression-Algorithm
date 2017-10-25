function [reconst_image, no_of_zeros, error_image, error_coeff] = block_dct2_quantize(image)
Q = [ 16    11    10    16    24    40    51    61;
      12    12    14    19    26    58    60    55;
      14    13    16    24    40    57    69    56;
      14    17    22    29    51    87    80    62;
      18    22    37    56    68   109   103    77;
      24    35    55    64    81   104   113    92;
      49    64    78    87   103   121   120   101;
      72    92    95    98   112   100   103    99];

reconst_image = [];
no_of_zeros = 0;
error_coeff = [];
error_image = [];
for row = 1:8:size(image,1)
    image_row= [];
    for col = 1:8:size(image,2)

        image_block = image(row:row+7, col:col+7);
        coeff_block = dct2(image_block);
        updated_coeff_block = Q.*round(coeff_block./Q);
    
        %calculating the number of zeros in the updated coeff block
        mask_zeros = updated_coeff_block == 0;
        no_of_zeros = no_of_zeros + sum(mask_zeros(:));
        
        %calculating the image back using updated_coeff_back
        new_image_block = idct2(updated_coeff_block);
        new_image_block = uint8(new_image_block);
        image_row = cat(2,image_row,new_image_block);
        
        %coeff of reconstructed image
        new_coeff_block = dct2(new_image_block);
        
        %calculating error for verification
        error_image = [error_image norm((double(image_block) - double(new_image_block)),'fro')];
        error_coeff = [error_coeff norm((double(coeff_block) - double(new_coeff_block)),'fro')];
    end
    reconst_image = cat(1,reconst_image, image_row);
end
end