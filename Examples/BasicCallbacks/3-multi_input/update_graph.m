function plotlyFig = update_graph(xaxis_column_name, yaxis_column_name, ...
                 xaxis_type, yaxis_type,  year_value)

    countryIndicators = readtable('country_indicators.csv');
    
    if year_value == 0
        year_value = min(countryIndicators.Year);
    end
    
    fig = figure('visible', 'off');
    subtab = countryIndicators(countryIndicators.Year == year_value, :);
    subtabX = subtab(cellfun(@(x) isequal(x, xaxis_column_name), subtab.IndicatorName), : );
    subtabY = subtab(cellfun(@(x) isequal(x, yaxis_column_name), subtab.IndicatorName), : );
    scatter(subtabX.Value,  subtabY.Value, 60, 'filled',...
        'MarkerEdgeColor', 'b', 'MarkerFaceColor', [0 0.5 0.5]);
    set(gca,'xscale', xaxis_type)
    set(gca,'yscale', yaxis_type)
    xlabel(gca, xaxis_column_name)
    ylabel(gca, yaxis_column_name)
    
    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    addtheme(fig, 'plotly_dark');
    
    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end
