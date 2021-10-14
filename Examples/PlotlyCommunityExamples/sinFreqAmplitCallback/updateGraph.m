function plotlyFig = updateGraph(frequency, amplitude)
    A = double(amplitude);
    F = double(frequency);

    figure('visible', 'off');

    t = (0:0.02:2*pi);
    plot(t, A*sin(2*pi*F*t), 'LineWidth', 1.5);
    xlabel(gca, 'Time', 'FontSize', 16);
    ylabel(gca, 'Amplitude', 'FontSize', 16);

    title(A+"&#183;sin(2&#183;&#960;&#183;"+F+"&#183;t)",...
        'FontSize', 20)

    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    addtheme(fig, 'plotly_dark');
    
    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end