terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Read data file
gdpLifeExp = readtable('https://gist.githubusercontent.com/chriddyp/5d1ea79569ed194d432e56108a04d188/raw/a9f9e8076b837d541398e999dcbac2b2826a81f8/gdp-life-exp-2007.csv');
continents = unique(gdpLifeExp.continent);
%colors={'red';'blue';'green';'black';'yellow'};
colors = 'rgbcmyk';
ax = axes();
%hold all
for i=1:length(continents)
    %continents{i}
    rows = (strcmp(gdpLifeExp.continent, continents{i}));
    subtab = gdpLifeExp(rows,:);

    scatter(ax, subtab.gdpPerCapita, subtab.lifeExpectancy,...
        subtab.population/100000, colors(i), 'filled',...
        'DisplayName', continents{i});
    hold on;
    %legend(ax, continents{i});
end
hold off;

set(ax, 'xscale', 'log');

xlabel(ax,'gdp per capita');
ylabel(ax,'life expectancy');
legend(ax);
%legend show
shg

myPlot = ui2dash(ax, 'graph');

components = {myPlot};

% Run the app.
layoutApp = startDash(components, 8057);