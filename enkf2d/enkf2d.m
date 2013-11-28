
%%
%   Standart EnKF. 
%
%   Implemenation based on J. Mandel: A  Brief Tutorial on 
%   the Ensemble Kalman Filter 
%   http://arxiv.org/abs/0901.3725
%
%
%   function XA=enkf2d(XF,H,d,r,f_cov_est)
%
%   XF - forecast ensemble
%   H - observation operator
%   d - observed data
%   r - variance of observed data
%   f_cov_est - function for estimating forecast covariance in 2D state
%%

function XA=enkf2d(XF,H,d,r,f_cov_est)
    %   N - number of ensemble members
    [n,~,N] = size(XF);
    %   observed data length
    d_l = length(d);
    R = diag(r);
    %   input data perturbation
    D = repmat(d,1,N) + diag(sqrt(r))*randn(d_l,N);
    
    % forecast covarince (f_cov_est must unroll state after xform)
    QF = f_cov_est(XF);
    
    % Kalman gain matrix
    M = (H * QF * H' + R);
    K = QF*H/M;
    
    % Analysis
    XFu = reshape(XF,n*n,N);
    XA=reshape(XFu+K*(D-H*XFu),n,n,N);
    
end