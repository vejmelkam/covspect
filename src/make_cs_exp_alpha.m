
%  Constructs a covariance representation in form c(0), c(1),...,c(m).
%  Covariance is modeled in form exp{-a(i-j)}.
%  Covariance is set to 0, when exp{-a(i-j)} is less then 1e-4.
%
%  cs=make_cs_exp_alpha(a) 
%  

function cs=make_cs_exp_alpha(a)
    cs(1) = 1;
    d=1;
    cs_d = exp(-a*d);
    while cs_d > 1e-4
        d=d+1;
        cs(d)=cs_d;
        cs_d=exp(-(a*d));
    end
end