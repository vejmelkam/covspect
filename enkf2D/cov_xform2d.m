

function C = cov_xform2d(XF,F)

    [n,~,N] = size(XF);
    XFw = zeros(size(XF));
    for i=1:N
        XFw(:,:,i) = F*XF(:,:,i)*F';
    end
    XFw = reshape(XFw,n*n,N);
    Cw = diag(diag(cov(XFw')));
    F2 = kron(F,F);
    C = real(F2'*Cw*F2);
    