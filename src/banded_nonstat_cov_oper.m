
%
%  Constructs a band matrix representation of a non-stationary covariance
%  operator that depends on the following parameters.
%
%  Cb = banded_nonstat_cov_oper(a,b,g,t,n,m)
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

function Cb = banded_nonstat_cov_oper(a,b,g,t,n,m)

    c = n + 2*m;
    w = 2*m+1;
    Cb = zeros(n,c);
    
    for i=1:n
        m = i + (w-1)/2;
        var_i = (1 + g + g*sin(pi*t*i/n));
        smooth_i = (1 + b + b*sin(pi*i/n));
        for j=i:i+w-1
            Cb(i,j) = var_i * exp(-abs(m-j)^a/smooth_i);
        end
    end
    