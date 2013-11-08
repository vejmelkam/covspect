
function [XA,YA] = enkf_lorenz96(n,N,f_cov_est)

    % observation operator
    H=eye(n);
    % variance of observation
    r=0.1*ones(size(H,1),1);
    %  parameters needed by lorenz 96
    F=8;
    kappa=1;
    dt=0.01;
    % initial run length
    init_run_length = 1000;
    % initial model state & observations
    Xinit = rand(n,1)*0.001-0.0005;
    Yinit = rand(n,1)*0.001-0.0005;
    % number of assimilation runs
    nar = 100;
    % assimilation time
    at=100;


    for t = 1:init_run_length
        Xinit=lorenz96(Xinit,dt,n,F,kappa);
        Yinit=lorenz96(Yinit,dt,n,F,kappa);
    end

    X=repmat(Xinit,1,N)+randn(n,N)*0.1;

    Y=Yinit;

    %  mean analysis ensemble after data assimilation
    XA=zeros(n,nar);
    %  obesrvation at assimilated time
    YA=zeros(n,nar);

    for ar_ind = 1:nar
        fprintf('analysis step  %g of %d\n', ar_ind,nar);
        X=enkf(X,H,Y,r,f_cov_est);
        XA(:,ar_ind)=mean(X,2);
        YA(:,ar_ind)=Y;
        for t_ind = 1:at
            for N_ind = 1:N
                X(:,N_ind) = lorenz96(X(:,N_ind),dt,n,F,kappa);    
            end
            Y = lorenz96(Y,dt,n,F,kappa);
        end   
    end
end