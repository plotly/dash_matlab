terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Title
title = uilabel('Text', 'Hello Dash',...
    'FontSize', 50, 'FontWeight', 'bold', 'FontColor', '#009dff',...
    'HorizontalAlignment', 'center');
myTitle = ui2dash(title, 'title');

subtitle = uilabel(...
    'Text', 'Dash: A web application framework for your data.',...
    'FontSize', 16, 'FontColor', '#009dff',...
    'HorizontalAlignment', 'center');
mySubtitle = ui2dash(subtitle, 'subtitle');

fruit = categorical({'Apples', 'Oranges', 'Bananas'});
amount = [4 2; 1 4; 2 5];
city = {'SF'; 'Montreal'};

% Figure
ax = axes();

barChart = bar(ax, fruit, amount);

xlabel(ax,'Fruit', 'Color', 'red');
ylabel(ax,'Amount', 'Color', 'red');

legend(ax, city);
ax.UserData = struct('theme', 'seaborn');

myPlot = ui2dash(ax, 'my-plot');

components = {myTitle, mySubtitle, myPlot};

% Run the app.
layoutApp = startDash(components, 8057, [], 'SOLAR');