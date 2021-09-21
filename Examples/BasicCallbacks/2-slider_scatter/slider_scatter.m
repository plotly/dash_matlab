terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create Dash app.
sliderApp = createApp();

% Read data file.
gapminderDataFiveYear = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv');

uiFig = uifigure('visible', 'off');
size = [12, 12];
uigrid = uigridlayout(uiFig, size);

% Create initial graph.
ax = axes(uigrid);
ax.Layout.Row = [3, 11];
ax.Layout.Column = [1, 12];

fig = figure('visible', 'off');
YEAR = 1952;
rows = (gapminderDataFiveYear.year == YEAR);
subtab = gapminderDataFiveYear(rows,:);
scatter(ax, subtab.gdpPercap, subtab.lifeExp,...
    subtab.pop/10000, categorical(subtab.country), 'filled');
set(gca,'xscale','log');
ax.Tag = 'graph';

% Create slider.
slider = uislider(uigrid, 'Tag', 'year');
slider.MajorTicks = [1952,1957,1962,1967,1972,1977,1982,1987,1992,1997,2002,2007];

% Define the callbacks.
args = {argsOut('graph', 'figure'), argsIn('year','value')};
handle = 'update_figure';
callbackDat = {args, handle};

% Run the app.
slider_app = startDash(uigrid, 8057, callbackDat);
