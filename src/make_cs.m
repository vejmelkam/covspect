


function cs=make_cs(type,m,a,b)
    switch lower(type)
        case {'exp'}
            d=0:m-1;
            cs=exp(-a*d.^b);
            cs=cs(cs>1e-4);
        case {'tri'}
            cs=(m:-1:1)/m;
        otherwise
            error('Type must be exp or tri.')
    end
end
