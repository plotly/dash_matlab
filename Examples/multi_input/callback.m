function plotlyFig = callback(xaxis_column_name, yaxis_column_name, ...
                 xaxis_type, yaxis_type,  year_value)

    tab = readtable('ind.csv');
    
    if year_value == 0
        year_value = min(tab.Year);
    end
    
    fig = figure('visible', 'off');
    subtab = tab(tab.Year == year_value, :);
    subtab1 = subtab(cellfun(@(x) isequal(x, xaxis_column_name), subtab.IndicatorName), : );
    subtab2 = subtab(cellfun(@(x) isequal(x, yaxis_column_name), subtab.IndicatorName), : );
    scatter(subtab1.Value,  subtab2.Value);%, [],  categorical(subtab2.CountryName), 'filled');
    set(gca,'xscale', xaxis_type)
    set(gca,'yscale', yaxis_type)
    title(gca, sprintf('TITLE FOR YEAR %s', num2str(year_value)));
    
    plotlyFig = jsonencode(fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false));
    close(fig)
end
