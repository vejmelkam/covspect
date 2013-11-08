
%
%  Constructs a matrix representation of a non-stationary covariance
%  operator that depends on the following parameters.  This function
%  DISREGARDS any boundary conditions that would be imposed by using a
%  particular spectral transform.  A function that constructs the band
%  operator 
%
%  CC = make_finite_cov_matrix(a,b,g,t,n,m)
%
%  a (alpha) - smoothness of covariance function
%  b (beta)  - variability of smoothness of covariance function with space
%  g (gamma) - controls the magnitude of grid point variance variability
%  t (theta) - frequency of grid point variance variability
%  n         - dimension of finite part of field
%  m         - controls the support of the covariance function
%
%  Note: for b = g = t = 0, the covariance operator represents a stationary
%  covariance.
%

function C = make_finite_cov_matrix(a,b,t1,g,t2,n,m)

    C = zeros(n);
    
    for i=1:n
        smooth_i = 1 + b + b*sin(pi*t1*(i-1)/n);
        var_i = 1 + g + g*sin(pi*t2*(i-1)/n);
        for j=i:min(i+m-1,n)
            c_ij = var_i * exp(-abs(j-i)^a/smooth_i);
            C(j,i) = c_ij;
            C(i,j) = c_ij;
        end
    end
    