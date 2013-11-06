
%  Constructs a covariance representation in form c(0), c(1),...,c(m).
%  Covariance is modeled in form exp{-(i-j)^b}.
%  Covariance is set to 0, when exp{-(i-j)^b} is less then 1e-4.
%
%  cs=make_cs_exp_beta(b) 
%  

function cs=make_cs_exp_beta(b)
    cs(1) = 1;
    d=1;
    cs_d = exp(-d^b);
    while cs_d > 1e-4
        d=d+1;
        cs(d)=cs_d;
        cs_d=exp(-(d^b));
    end
end