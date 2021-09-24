terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Read data file
gdpLifeExp = readtable('https://gist.githubusercontent.com/chriddyp/5d1ea79569ed194d432e56108a04d188/raw/a9f9e8076b837d541398e999dcbac2b2826a81f8/gdp-life-exp-2007.csv');
continents = unique(gdpLifeExp.continent);
clrs={'red';'blue';'green';'black';'yellow'};

% Create Dash app
app = createApp();

uiFigure = uifigure('visible', 'off');
size = [3, 3];
uiGrid = uigridlayout(uiFigure, size);

% Create Graph.
fig = figure('visible', 'off');
ax = axes(uiGrid);
hold(ax, 'on')

for i=1:length(continents)
    rows = (strcmp(gdpLifeExp.continent, continents{i}));
    subtab = gdpLifeExp(rows,:);

    scatter(ax, subtab.gdpPerCapita, subtab.lifeExpectancy,...
        subtab.population/10000, clrs{i}, 'filled');
end

set(ax, 'xscale', 'log');

xlabel(ax,'gdp per capita');
ylabel(ax,'life expectancy');

ax.Tag = 'graph';

% Run the app.
layoutApp = startDash(uiGrid, 8057);