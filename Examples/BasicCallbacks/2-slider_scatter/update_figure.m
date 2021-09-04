function plotlyFig = update_figure(year)

    gapminderDataFiveYear = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv');
    
    if year == 0
        year = min(gapminderDataFiveYear.year);
    end
    
    fig = figure('visible', 'off');
    YEAR = year;
    rows = (gapminderDataFiveYear.year == YEAR);
    subtab = gapminderDataFiveYear(rows,:);
    scatter(subtab.gdpPercap, ...
        subtab.lifeExp, ...
        subtab.pop/10000, ...
        categorical(subtab.country), 'filled');
    set(gca,'xscale','log')

    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);

    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end
