
%
%  Constructs a band matrix representation of a non-stationary covariance
%  operator that depends on parameters alpha, beta, gamma, 
%
%

function Cb = make_banded_cov_oper(a,b,g,t,n,m)

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
    