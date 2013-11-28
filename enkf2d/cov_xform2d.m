

function C = cov_xform2d(XF,F)

    [n,~,N] = size(XF);
    
    % transform each of the ensemble members using a tensor product
    % of 1D transforms
    XFw = zeros(size(XF));
    for i=1:N
        XFw(:,:,i) = F*XF(:,:,i)*F';
    end
    
    % apply vec() operation to each member
    XFw = reshape(XFw,n*n,N);
    XFm = mean(XFw,2);
    
    % compute the diagonal of the covariance in spectral space
    % the following is equal to Cw = diag(diag(cov(XFw')));
    Cw = zeros(n*n,1);
    for i=1:n*n
        Cw(i) = (XFw(i,:) - XFm(i))*(XFw(i,:) - XFm(i))';
    end
    Cw = Cw / (N-1);
    
    F2 = kron(F,F);
    %the following is the same as C = real(F2'*Cw*F2) when Cw is diagonal
    C = real((F2' .* Cw(:,ones(n*n,1))') * F2);
    