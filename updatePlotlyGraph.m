function plotlyFig = updatePlotlyGraph(year)

    set(0,'DefaultFigureVisible','off')
    tab = readtable('dat.csv');
    
    fig = figure('visible', 'off');
    YEAR = year;
    rows = (tab.year == YEAR);
    subtab = tab(rows,:);
    scatter(subtab.gdpPercap, ...
        subtab.lifeExp, ...
        subtab.pop/10000, ...
        categorical(subtab.country), 'filled');
    set(gca,'xscale','log')
    
    plotlyFig = jsonencode(fig2plotly(gcf, 'offline', true, 'open', false))
end
