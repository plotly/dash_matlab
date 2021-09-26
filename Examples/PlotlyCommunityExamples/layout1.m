terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create Dash app
app = createApp();

uiFigure = uifigure('visible', 'off');
size = [3, 3];
uiGrid = uigridlayout(uiFigure, size);

% Title
title = uilabel(uiGrid, 'Text', 'Hello Dash',...
    'FontSize', 50, 'FontWeight', 'bold');

subtitle = uilabel(uiGrid,...
    'Text', 'Dash: A web application framework for your data.',...
    'FontSize', 16);

subtitle.Layout.Row = 2;

fruit = categorical({'Apples', 'Oranges', 'Bananas'});
amount = [4 2 3; 1 4 7; 2 5 1];
city = {'SF'; 'Montreal'; 'Bs As'};

% Figure
ax = axes(uiGrid);
ax.Layout.Row = 3;

barChart = bar(ax, fruit, amount);
set(barChart, {'DisplayName'}, city);
xlabel(ax,'Fruit');
ylabel(ax,'Amount');

% Run the app.
layoutApp = startDash(uiGrid, 8057);