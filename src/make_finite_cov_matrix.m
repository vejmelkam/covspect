
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

function C = make_finite_cov_matrix(a,b,e1,g,e2,n,m)

    C = zeros(n);

    s_switch = double(prod(((repmat((0:n-1)',1,length(e1)) < repmat(e1,n,1))-0.5)*2,2) > 0);
    v_switch = double(prod(((repmat((0:n-1)',1,length(e2)) < repmat(e2,n,1))-0.5)*2,2) > 0);
    
    smooth = 1 + b*s_switch;
    var = 1 + g*v_switch;
    
    for i=1:n
        for j=i:min(i+m-1,n)
            c_ij = var(i) * exp(-(abs(j-i)/smooth(i))^a);
            C(j,i) = c_ij;
            C(i,j) = c_ij;
        end
    end
    
    C = C .* (s_switch * s_switch' + (1-s_switch)*(1-s_switch)');
    C = C .* (v_switch * v_switch' + (1 - v_switch)*(1-v_switch)');
    
    