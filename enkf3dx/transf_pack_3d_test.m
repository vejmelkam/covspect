%   Test file for transf_pack_3d.m and itransf_unpack_3d.m functions

%   x, y, z dimension
nx = 4;
ny = 8;
nz = 16;
%   random 3 dimensional array

A = randn(nx,ny,nz);

%   fourier transform
FA = transf_pack_3d(A,@(n) fft_matrix(n));

%   should be same as
fftA = fftn(A) * 1/(sqrt(nx)*sqrt(ny)*sqrt(nz));
%   should be nearly zero
max(abs(FA - fftA(:)))

%   inverse 
iFA = itransf_unpack_3d(FA,nx,ny,nz,1,@(n) fft_matrix(n)' );
%   should be nearly zero
max(abs(iFA(:) - A(:)))
%   

% more variables and more ensemble members
N=10;
nvar=5;
nx = 16;
ny = 32;
nz = 16;
A = randn(nx,ny,nz,nvar,N);

FA=transf_pack_3d(A,@(n) fft_matrix(n));
iFA=itransf_unpack_3d(FA,nx,ny,nz,nvar,@(n) fft_matrix(n)');

% should be 0
max(abs(iFA(:)-A(:)))







