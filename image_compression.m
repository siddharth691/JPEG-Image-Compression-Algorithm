N = 8;

dct_basis_1d = @(k,n,N)(k==0).*(1/N)^(0.5) + (k>0).*(((2/N)^0.5).*cos((pi/N).*k.*(n+0.5)));
dct_basis_2d = @(j,k,m,n,N) dct_basis_1d(j,m,N).*dct_basis_1d(k,n,N);
m = 0:1:N-1;
n = 0:1:N-1;
size_of_image = [N,N];
[nn,mm] = meshgrid(m,n); %since mm are row index of a image and nn are column index of the image
m_n = cat(2, reshape(mm, [numel(mm),1]), reshape(nn, [numel(nn),1]));
basis_iter = 1;
for j = 0:1:N-1
    for k = 0:1:N-1
        basis = reshape(dct_basis_2d(j,k,m_n(:,1),m_n(:,2),N),size_of_image);
        basis = (basis)./(max(max(basis)));
        subplot(8,8,basis_iter)
        imshow(basis, [0,1])
        basis_iter = basis_iter + 1;
    end
end

        





