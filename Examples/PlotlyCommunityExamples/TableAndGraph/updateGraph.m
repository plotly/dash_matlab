function plotlyFig = updateGraph(tableData, dropdownValue)
    n = length(tableData);
    x = zeros(1,n);
    y = zeros(1,n);
    
    for i=1:n           
        if ~isnumeric(tableData{i}.x)
            x(i) = str2double(tableData{i}.x);
        else
            x(i) = tableData{i}.x;
        end
        
        if ~isnumeric(tableData{i}.y)
            y(i) = str2double(tableData{i}.y);
        else
            y(i) = tableData{i}.y;
        end
    end

    close all;
    switch dropdownValue % {'Line'; 'Scatter'; 'Bar'}
        case 'Line'
            plot(x,y, 'LineWidth', 1.5);
        case 'Scatter'
            scatter(x, y, 80, 'filled')
        case 'Bar'
            bar(y)
    end
    xlabel(gca, 'x', 'FontSize', 16);
    ylabel(gca, 'y', 'FontSize', 16);
    title(strcat(dropdownValue, ' Plot'), 'FontSize', 20);

    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    addtheme(fig, 'plotly_dark');
    
    plotlyFig1 = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    plotlyFig = char(jsonencode(plotlyFig1));
end