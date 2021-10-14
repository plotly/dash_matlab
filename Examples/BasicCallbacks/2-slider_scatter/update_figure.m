function plotlyFig = update_figure(yearVar)

    gapminderDataFiveYear = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv');
    
    if yearVar == 0
        yearVar = min(gapminderDataFiveYear.year);
    end
    
    rows = (gapminderDataFiveYear.year == yearVar);
    subtab = gapminderDataFiveYear(rows,:);
    scatter(subtab.gdpPercap, ...
        subtab.lifeExp, ...
        subtab.pop/100000, ...
        categorical(subtab.country), 'filled');
    set(gca,'xscale','log');
    set(gca,'FontSize',14);
    xlabel(gca, 'gdpPercap');
    ylabel(gca, 'lifeExp');    

    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    addtheme(fig, 'plotly_dark');

    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end
