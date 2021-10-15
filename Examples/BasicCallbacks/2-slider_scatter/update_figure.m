function plotlyFig = update_figure(yearVar)

    gapminderDataFiveYear = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv');
    continents = unique(gapminderDataFiveYear.continent);
    colors = 'rgbcmyk';
    
    if yearVar == 0
        yearVar = min(gapminderDataFiveYear.year);
    end
    
    rows = (gapminderDataFiveYear.year == yearVar);
    subtab = gapminderDataFiveYear(rows,:);    
    close all;
    hold on;
    for i=1:length(continents)
        rowsCont = (strcmp(subtab.continent, continents{i}));
        subtabCont = subtab(rowsCont,:);
        
        scatter(gca, subtabCont.gdpPercap, subtabCont.lifeExp, ...
            subtabCont.pop/100000, colors(i), 'filled',...
            'DisplayName', continents{i},...
            'MarkerFaceAlpha',.8,'MarkerEdgeAlpha',.8);
    end
    hold off;
    
    set(gca,'xscale','log');
    set(gca,'FontSize',14);
    xlabel(gca, 'gdpPercap');
    ylabel(gca, 'lifeExp'); 
    legend(gca);

    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    addtheme(fig, 'plotly_dark');

    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end
