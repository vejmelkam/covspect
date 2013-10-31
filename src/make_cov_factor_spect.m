

function U = make_cov_factor_spect(n,d1,d2)

    U = zeros(n);
    U = U + diag((1:n).^(-d1));

    if (d2 > 0)
        f = exp(-(1:n-1)/d2);
        for i=1:n
            U(i,i+1:n) = U(i,i) .* f(1:n-i);
        end
    end
    
