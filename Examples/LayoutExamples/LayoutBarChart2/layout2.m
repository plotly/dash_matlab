terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Title
myTitle = Html('H1', {'children', 'Hello Dash',...
    'style', struct(...
        'textAlign', 'center',...
        'color', '#7FDBFF')});

% Subtitle
mySubtitle = Html('Div', {...
    'children', 'Dash: A web application framework for your data.',...
    'style', struct(...
        'textAlign', 'center',...
        'color', '#7FDBFF')});

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

myPlotCenter = Html('Center', {'children', myPlot});

components = {myTitle, mySubtitle, myPlotCenter};

% Run the app.
startDash(components, 8057, [], 'DARKLY');