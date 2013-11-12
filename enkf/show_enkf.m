

function show_enkf(XA,YA)

    figure('name','ENKF diagnostics')
    
    subplot(221);
    imagesc(XA);
    title('Ensemble average');
    subplot(222);
    imagesc(YA);
    title('"True" state');
    subplot(223);
    imagesc(XA-YA);
    title('Kf error');
    subplot(224);
    plot(sum((XA-YA).^2).^0.5);
    title('RMSE');