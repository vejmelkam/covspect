

function M = wav_mask(n,ss)

    M = eye(n);
    for s=ss
        M(2^(s-1):2^s-1, 2^(s-1):2^s-1) = 1;
    end
    