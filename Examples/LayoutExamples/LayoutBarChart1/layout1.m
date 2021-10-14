terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Title
title = uilabel('Text', 'Hello Dash',...
    'FontSize', 50, 'FontWeight', 'bold', 'FontColor', 'white');
myTitle = ui2dash(title, 'title');

% Subtitle
subtitle = uilabel(...
    'Text', 'Dash: A web application framework for your data.',...
    'FontSize', 16, 'FontColor', 'white');
mySubtitle = ui2dash(subtitle, 'subtitle');

% Figure
fruit = categorical({'Apples', 'Oranges', 'Bananas'});
amount = [4 2; 1 4; 2 5];
city = {'SF'; 'Montreal'};

ax = axes();

barChart = bar(ax, fruit, amount);

xlabel(ax,'Fruit', 'FontSize', 16);
ylabel(ax,'Amount', 'FontSize', 16);
legend(ax, city);
ax.UserData = struct('theme', 'plotly_dark');

myPlot = ui2dash(ax, 'my-plot');

components = {myTitle, mySubtitle, myPlot};

% Run the app.
startDash(components, 8057, [], 'DARKLY');