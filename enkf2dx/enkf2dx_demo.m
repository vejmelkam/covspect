
n=32;
nvar=3;
N=4;
height=4;
dh=2;   %drop height
dw=4;   %drop width
rl=40;  %assimilation run length
init_steps=1000;
ap = 100; %assimiltion period    
Y=zeros(n,n,nvar,rl);Y(:,:,1,1)=ones(n,n)*height;
Z=zeros(n,n,nvar,rl);Z(:,:,1,1)=ones(n,n)*height;


dx=1;
dy=1;
dt=0.01;
Y(1:dw,1:dw,1,1)=squeeze(Y(1:dw,1:dw,1,1))+droplet(dh,dw);
Z(dw/2+1:dw*1.5,dw/2+1:dw*1.5,1,1)=squeeze(Z(dw/2+1:dw*1.5,dw/2+1:dw*1.5,1,1))+droplet(dh,dw);

Y(:,:,:,1)=waterwave2(squeeze(Y(:,:,:,1)),dt,dx,dy,init_steps);
Z(:,:,:,1)=waterwave2(squeeze(Z(:,:,:,1)),dt,dx,dy,init_steps);


for rl_ind = 2:rl
    Y(:,:,:,rl_ind) = waterwave2(squeeze(Y(:,:,:,rl_ind-1)),dt,dx,dy,ap);
    Z(:,:,:,rl_ind) = waterwave2(squeeze(Z(:,:,:,rl_ind-1)),dt,dx,dy,ap);
end

ens_init = repmat(squeeze(Z(:,:,:,1)),[1 1 1 N]) + randn(n,n,nvar,N)*0.1;
obs = squeeze(Y(:,:,1,:));

F = fft_matrix(n);
AF = assim2d(ens_init,obs,@(x) waterwave2(x,dt,dx,dy,ap),@(x,y) enkf2dx(x,y,0.1,1,F,F));

W = wav_matrix(n,2,'Coiflet',2);
AW = assim2d(ens_init,obs,@(x) waterwave2(x,dt,dx,dy,ap),@(x,y) enkf2dx(x,y,0.1,1,W,W));

%enkf2dx_anim(AF,Y,AW,1);
% 
figure('name','RMSE');
rmse = enkf2dx_rmse(AF,Y,AW);
plot(squeeze(rmse(:,1,:))');
legend('FFT','Wav');

 
M = zeros(n,n);
M(10,10) = 1;
 
AFsg = assim2d(ens_init,obs,@(x) waterwave2(x,dt,dx,dy,ap),@(x,y) enkf2dx_sgo(x,y,M,0.1,1,F,F));
AWsg = assim2d(ens_init,obs,@(x) waterwave2(x,dt,dx,dy,ap),@(x,y) enkf2dx_sgo(x,y,M,0.1,1,W,W));
 
 figure('name','RMSE - subgrid observed');
 rmse_sg = enkf2dx_rmse(AFsg,Y,AWsg);
 plot(squeeze(rmse_sg(:,1,:))');
 legend('FFT','Wav');
 
 


