

function Cb = cov_banded(cs, n)
    m = length(cs) - 1;
    s = n+2*m;
    r = [cs, zeros(1, s - m - 1)];
    Cb = toeplitz(r, r);
end
