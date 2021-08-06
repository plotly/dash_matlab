function plotlyFig = callback(stock)

Apple_data = importfile("data.xlsx", "Apple", [2, 1158]);
Coke_data = importfile("data.xlsx", "Coke", [2, 1158]);
Tesla_data = importfile("data.xlsx", "Tesla", [2, 1158]);

fig = figure('visible', 'off', 'Position', [0, 0, 800, 400]);
if strcmp(stock, 'Apple') 
    plot(Apple_data.Close, 'LineWidth', .75)
elseif strcmp(stock, 'Coke')
    plot(Coke_data.Close, 'LineWidth', .75)
else
    plot(Tesla_data.Close)
end
title(gca, sprintf(' Line plot for %s stock', num2str(stock)), 'Fontsize', 20);
xlabel('Date Index')
ylabel('Closing Value')
grid('on')


plotlyFig = jsonencode(fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false));
close(fig)
fig = plotlyfig2dash(fig2plotly(gcf, 'offline', true, 'open', false,'Visible',false), 'lineplot');

end