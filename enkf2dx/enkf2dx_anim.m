%   simple animation for enkf2dx assimilation 
%
%
%
%   function enkf2dx_anim(X,Y,Z,var)
%
%   X - analysis 1
%   Y - true state
%   Z - analysis 2, or reference 
%   var - ploted variable


function enkf2dx_anim(X,Y,Z,var)
    [nx,ny,~,rl] = size(X);
    X = squeeze(X(:,:,var,:));
    Y = squeeze(Y(:,:,var,:));
    Z = squeeze(Z(:,:,var,:));
    figure('name','2D EnKF with diag. cov. approx. in spect. space');
    zmin = min([X(:);Y(:);Z(:)]);
    zmax = max([X(:);Y(:);Z(:)]);
    for rl_ind = 1:rl
        subplot(131);
        surf(squeeze(X(:,:,rl_ind)));
        zlim([zmin zmax]);
        title('Analysis 1');
        subplot(132);
        surf(squeeze(Y(:,:,rl_ind)));
        zlim([zmin zmax]);
        title('True state');
        subplot(133);
        surf(squeeze(Z(:,:,rl_ind)));
        zlim([zmin zmax]);
        title('Analysis 2');
        pause(1);
    end
end