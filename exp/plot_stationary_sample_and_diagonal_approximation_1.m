
%% This is a plotting script for the results of exp_stationary_sample_and_diagonal_approximation
% Ploting relative error of sample and diagonal approximation of covariance
% of s

for cs_ind=1:length(cs_parms)
    figure('name',['cs parameter: ',num2str(cs_parms(cs_ind))]);
    cs_parm=cs_parms(cs_ind);
    for t_ind = 1:length(pmethods)
        subplot(1,length(pmethods),t_ind);
        plot(pN,mean(squeeze(results(cs_ind,:,t_ind,:,1)),2),'go-'); hold on;
        plot(pN,mean(squeeze(results(cs_ind,:,t_ind,:,2)),2),'bo-'); hold off;
        legend('sample','diagonal');
        xlabel('ensemble size')
        ylabel('Cov. est. rel. Frob. error')
        title(pmethods(t_ind))
    end
end
