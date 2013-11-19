
%%
%   Standard EnKF with observation of entire vector. 
%
%   Implemenation based on J. Mandel: A  Brief Tutorial on 
%   the Ensemble Kalman Filter 
%   http://arxiv.org/abs/0901.3725
%
%
%   function XA=enkf2dx(XF,H,d,r,f_cov_est)
%
%   XF - forecast ensemble
%   d - observed data (column vector)
%   r - variance of observed data (column vector)
%   f_cov_est - function for estimating forecast covariance
%%

function XA=enkf2dx(XF,H,d,r,f_cov_estx)
    % n - spatial dimension (must be square)
    % N - number of ensemble members
    [n,~,N] = size(XF);
    
    % construct observation variance (sparse matrix with r in observation
    % locations and 0 in unobserved locations)
    R = spdiags(r);
    
    % data perturbation has zeros
    D = repmat(d,1,N) + sqrt(r)*randn(3*n*n,N);
    
    % forecast covarince in spectral space (must return diagonal)
    QF = f_cov_estx(XF);
    
    % Kalman gain matrix
    M = (H * QF * H' + R);
    K = QF*H/M;
    
    % Analysis
    XFu = reshape(XF,n*n,N);
    XA=reshape(XFu+K*(D-H*XFu),n,n,N);
    
end