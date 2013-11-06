
%% This is a plotting script for the results of exp_stationary_sample_and_diagonal_approximation
%  It compares only errors for of diagonal approximations in 
%  different spectral spaces
%%
figure('name','diagonal approximation relative error')

for cs_ind=1:length(cs_parms)
    subplot(1,length(cs_parms),cs_ind);
    plot(pN,mean(squeeze(results(cs_ind,:,1,:,2)),2),'go-'); hold on;
    plot(pN,mean(squeeze(results(cs_ind,:,2,:,2)),2),'bo-'); 
    plot(pN,mean(squeeze(results(cs_ind,:,3,:,2)),2),'ro-'); hold off;
    legend(pmethods);
    xlabel('ensemble size')
    ylabel('Cov. est. rel. Frob. error')
    title(['cs parameter = ',num2str(cs_parms(cs_ind))])
    
end
