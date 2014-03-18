n=32;
m=3;
N=4;
height=4;
dh=2;   %drop height
dw=4;   %drop width

    
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
 XF=repmat(Z,[1 1 1 N]) + randn(n,n,m,N)*0.1;
 XW=repmat(Z,[1 1 1 N]) + randn(n,n,m,N)*0.1;
 % assimilation time
 ass_time=100;
 
 run_length=60;

 XAF=zeros(n,n,m,run_length);
 XAW=zeros(n,n,m,run_length);
 YA=zeros(n,n,m,run_length);
 ZA=zeros(n,n,m,run_length);

 QF = fft_matrix(n);
 QW = wav_matrix(n,4,'Coiflet',4);
 for run_ind=1:run_length
        fprintf('.');
        
        for ens_ind=1:N
            XF(:,:,:,ens_ind)=waterwave2(squeeze(XF(:,:,:,ens_ind)),dt,dx,dy,ass_time);
            XW(:,:,:,ens_ind)=waterwave2(squeeze(XW(:,:,:,ens_ind)),dt,dx,dy,ass_time);
        end
        Y=waterwave2(Y,dt,dx,dy,ass_time);
        Z=waterwave2(Z,dt,dx,dy,ass_time);

        %  EnKF
        XF=enkf2dx(XF,squeeze(Y(:,:,1)),0.01,1,QF,QF);
        XW=enkf2dx(XW,squeeze(Y(:,:,1)),0.01,1,QW,QW);
        
        XAF(:,:,:,run_ind)=unpack_state(mean(pack_state(XF),2),n,n);
        XAW(:,:,:,run_ind)=unpack_state(mean(pack_state(XW),2),n,n);
        YA(:,:,:,run_ind)=Y;
        ZA(:,:,:,run_ind)=Z;

        if mod(run_ind,15)==0 
            Y(1:dw,1:dw,1)=squeeze(Y(1:dw,1:dw,1))+droplet(dh,dw);
            Z(1:dw,1:dw,1)=squeeze(Z(1:dw,1:dw,1))+droplet(dh,dw);
            for ens_ind=1:N
                XF(1:dw,1:dw,1,ens_ind)=squeeze(XF(1:dw,1:dw,1,ens_ind))+droplet(dh,dw);
                XW(1:dw,1:dw,1,ens_ind)=squeeze(XW(1:dw,1:dw,1,ens_ind))+droplet(dh,dw);
            end
            
            fprintf('\n');
        end
 end
 
 % animation
 figure(1);
 subplot
