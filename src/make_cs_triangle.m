
%  Constructs a tringular  covariance representation in form c(0), c(1), 
%  ...., c(m) 
%
%  cs=make_cs_traingle(m)
%
%  m - number of nonzero elements 
%  

function cs=make_cs_traingle(m)
    cs=m:-1:1/m;
end