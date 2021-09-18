terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create Dash app
app = createApp();

uifig = uifigure('visible', 'off');
uigrid = uigridlayout(uifig);

% Title
title = uilabel(uigrid, 'Text', 'Hello Dash',...
    'FontSize', 50, 'FontWeight', 'bold', 'FontColor', 'blue');

title.Layout.Row = 1;

subtitle = uilabel(uigrid,...
    'Text', 'Dash: A web application framework for your data.',...
    'FontSize', 16);

subtitle.Layout.Row = 2;

Fruit = categorical({'Apples', 'Oranges', 'Bananas'});
Amount = [4 2; 1 4; 2 5];
City = {'SF'; 'Montreal'};

% Figure
ax = axes(uigrid);
ax.Layout.Row = 3;

b = bar(ax, Fruit, Amount);
set(b, {'DisplayName'}, City);
xlabel(ax,'Fruit');
ylabel(ax,'Amount');


ax.Tag = 'example-graph'; % id for the bar graph

% Run the app.
lay_app = startDash(uigrid, 8057);