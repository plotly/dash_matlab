function plotlyFig = update_figure(slider_range)
    irisData = readtable('https://gist.githubusercontent.com/curran/a08a1080b88344b0c8a7/raw/0e7a9b0a5d22642a06d3d5b9bcbad9890c8ee534/iris.csv');
    low = slider_range{1};
    high = slider_range{2};

    figure('visible', 'off');

    rows = (irisData.petal_width > low & irisData.petal_width < high);
    subtab = irisData(rows,:);

    color = lines(3); % Generate color values
    
    gscatter(subtab.sepal_width, subtab.sepal_length,...
        categorical(subtab.species),... % Group
        color,... % Color
        '.', 40); % Symbol and size

    set(gca,'FontSize',14);
    xlabel(gca, 'sepal width');
    ylabel(gca, 'sepal length');

    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);

    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end
