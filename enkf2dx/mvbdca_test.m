%   Test script for function mvbdca.m
%   mvdbca(X,m,i)   
%
%   When size(X,1) == m then result should be just diagonal elements of
%   sample covariance

A = randn(150,15) + j*randn(150,15);
%   sample covariance
C_N = cov(a');
E = mvbdca(a,150,1);
%   should be zero
max(abs(E-diag(C_N)))


%%
%   Test with multiple variables, selected variable on position i 

m = 10; % number of variables
nv = 100; % dimension of variables
N = 15; % number of ensembles
i = 3;

A = randn(m*nv,N) + randn(m*nv,N)*i;
C_N = cov(A.');
D = zeros(m*nv,1);
% ith variable row from to 
ivrf = (i-1)*nv+1;
ivrt = i*nv;
for m_i = 1:m
    rf = (m_i-1)*nv+1;
    rt = m_i*nv;
    D(rf:rt) = diag(C_N(rf:rt,ivrf:ivrt));
end
E = mvbdca(A,nv,i);

% should be (reaslly close to ) 0
max(abs(D-E))



