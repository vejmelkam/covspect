
%%
%   ensemble Kalman filter 2 dimensionval with spectral diagonal
%   approximation of forecast covariance - subgrid observed only 
%   
%
%   Implemenation based on J. Mandel: A  Brief Tutorial on 
%   the Ensemble Kalman Filter 
%   http://arxiv.org/abs/0901.3725
%
%
%   function XA=enkf2dx(XF,H,d,r,f_cov_est)
%
%   XF - forecast ensemble
%   d - observed data (matrix) - full state 
%   m - mask matrix, (1 - observed value, 0 - not observed)
%   r - variance of observed data - covariance matrix of observed data is
%   then r*I
%   i - index of observed variable
%   Q - transformation matrix
%  
%%
function XA=enkf2dx_sgo(XF,d,M,r,i,Qx,Qy)
    X = eens2d(XF,M,i);
    d = d.*M;
    XA = enkf2dx(X,d,r,i,Qx,Qy);
    XA = rens2d(XA);
end