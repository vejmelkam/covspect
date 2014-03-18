function [XA,YA,ZA] = enkf2dx_ww_test(n, N, Q, run_length, obs_var)

    m=3;         % number of variables
    height=4;    % height of water
    dh=2;        % drop height
    dw=4;        % drop width
    ass_time=100; % assimilation time
    
    Y=zeros(n,n,m);Y(:,:,1)=ones(n,n)*height;
    Z=zeros(n,n,m);Z(:,:,1)=ones(n,n)*height;
    init_steps=1000;
    dx=1;
    dy=1;
    dt=0.01;
    Y(1:dw,1:dw,1)=squeeze(Y(1:dw,1:dw,1))+droplet(dh,dw);
    Z(dw/2+1:dw*1.5,dw/2+1:dw*1.5,1)=squeeze(Z(dw/2+1:dw*1.5,dw/2+1:dw*1.5,1))+droplet(dh,dw);

    Y=waterwave2(Y,dt,dx,dy,init_steps);
    Z=waterwave2(Z,dt,dx,dy,init_steps);
 
    %initial ensemble
    X=repmat(Z,[1 1 1 N]) + randn(n,n,m,N)*0.1;

    % assimilation time

    XA=zeros(n,n,m,run_length);
    YA=zeros(n,n,m,run_length);
    ZA=zeros(n,n,m,run_length);

for run_ind=1:run_length
    fprintf('.');

    for ens_ind=1:N
        X(:,:,:,ens_ind)=waterwave2(squeeze(X(:,:,:,ens_ind)),dt,dx,dy,ass_time);
    end
    Y=waterwave2(Y,dt,dx,dy,ass_time);
    Z=waterwave2(Z,dt,dx,dy,ass_time);

    %  EnKF
    X=enkf2dx(X,squeeze(Y(:,:,obs_var)),0.01,obs_var,Q);

    XA(:,:,:,run_ind)=unpack_state(mean(pack_state(X),2),n);
    YA(:,:,:,run_ind)=Y;
    ZA(:,:,:,run_ind)=Z;

end
fprintf('\n'); 
 
%  subplot(131);surf(YA(:,:,1,run_length));
%  subplot(132);surf(XA(:,:,1,run_length));
%  subplot(133);surf(ZA(:,:,1,run_length));
 
