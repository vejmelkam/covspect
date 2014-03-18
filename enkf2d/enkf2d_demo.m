%   Demo for 2D EnKF using spectral diagonal approximation of forecast
%   covariance matrix. 
%
%   !!! WARNING: ENKF IMPLEMENTED USING KRONECKER PRODUCT - LOT OF MEMORY  
%   NEEDED - for memory efficient implementation see enkf2dx_demo.m !!!
%
%
%   Model: shallow water equations 
%
%   Assimilated variable: height
%
%   crosscovariances between variables set to 0

n=32;
N=4;
ass_step=10;
[X,Y,Z] = enkf2d_wwave(n,N,ass_step,@(X) cov_xform2d(X,wav_matrix(n,2,'Coiflet',2)));



