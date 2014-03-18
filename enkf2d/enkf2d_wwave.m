
function [XA,YA,ZA] = enkf2d_wwave(n,N,nsteps,H,f_cov_est)

    % variance of observation
    r=0.01*ones(size(H,1),1);
    % integration time-step for water model
    dt = 0.01;
    dx = 1;
    dy = 1;
    height = 5;
    drop_size = 11;
    % integration steps to run between observations
    isteps = 10;
    % initial run length
    init_steps = 1000;
    % initial model state & observations
    
    % construct initial conditions - reference model (Y)
    Hy = ones(n) * height;
    Uy = zeros(n);
    Vy = zeros(n);
    Hy(1:drop_size,1:drop_size) = Hy(1:drop_size,1:drop_size) + droplet(1,drop_size);
    [Hy,Uy,Vy] = waterwave(Hy,Uy,Vy,dt,dx,dy,init_steps);

    % construct initial conditions - unassimilated model (Z)
    Hz = ones(n) * height;
    Uz = zeros(n);
    Vz = zeros(n);
    Hz(4:drop_size+3,4:drop_size+3) = Hz(4:drop_size+3,4:drop_size+3) + droplet(1,drop_size);
    [Hz,Uz,Vz] = waterwave(Hz,Uz,Vz,dt,dx,dy,init_steps);
    
    % construct an ensemble of wave models
    HX=repmat(Hz,[1 1 N])+randn(n,n,N)*0.01;
    UX=repmat(Uz,[1 1 N]);
    VX=repmat(Vz,[1 1 N]);

    %  mean analysis ensemble after data assimilation
    XA=zeros(n,n,nsteps);
    YA=zeros(n,n,nsteps);
    ZA=zeros(n,n,nsteps);

    for ar_ind = 1:nsteps
        
        fprintf('.');
        if mod(ar_ind,20) == 0
            fprintf('\n');
        end
        
        % perform an ENKF step and store mean ensemble state
        HX=enkf2d(HX,H,H*Hy(:),r,f_cov_est);
        XA(:,:,ar_ind)=mean(HX,3);
        YA(:,:,ar_ind)=Hy;
        ZA(:,:,ar_ind)=Hz;
        
        % iterate all models further
        for N_ind = 1:N
            [HX(:,:,N_ind),UX(:,:,N_ind),VX(:,:,N_ind)] = waterwave(HX(:,:,N_ind),UX(:,:,N_ind),VX(:,:,N_ind),dt,dx,dy,isteps);    
        end
        
        % also, add some droplets
%        Hy(1:21,1:21) = Hy(1:21,1:21) + droplet(1,21);
        [Hy,Uy,Vy] = waterwave(Hy,Uy,Vy,dt,dx,dy,isteps);
        
        [Hz,Uz,Vz] = waterwave(Hz,Uz,Vz,dt,dx,dy,isteps);
        
%         if((ar_ind > 100) && (mod(ar_ind,20)==0))
%             subplot(131);
%             imagesc(XA(:,:,ar_ind));
%             subplot(132);
%             imagesc(YA(:,:,ar_ind));
%             subplot(133);
%             imagesc(ZA(:,:,ar_ind));
%             pause;
%         end
    end 
end
