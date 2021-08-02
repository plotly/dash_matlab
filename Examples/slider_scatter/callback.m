function plotlyFig = callback(year)

    tab = readtable('dat.csv');
    
    if year == 0
        year = min(tab.year);
    end
    
    fig = figure('visible', 'off');
    YEAR = year;
    rows = (tab.year == YEAR);
    subtab = tab(rows,:);
    scatter(subtab.gdpPercap, ...
        subtab.lifeExp, ...
        subtab.pop/10000, ...
        categorical(subtab.country), 'filled');
    set(gca,'xscale','log')
    title(gca, sprintf('TITLE FOR YEAR %s', num2str(YEAR)));
    
    plotlyFig = jsonencode(fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false))
    close(fig)
end
