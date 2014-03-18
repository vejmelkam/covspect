

function C = cov_sample2d(XF)

    [n,~,N] = size(XF);
    XF = reshape(XF,n*n,N);
    C = cov(XF');
    