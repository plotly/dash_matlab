clear all; close all;

% Read data file
gdpLifeExp = readtable('https://gist.githubusercontent.com/chriddyp/5d1ea79569ed194d432e56108a04d188/raw/a9f9e8076b837d541398e999dcbac2b2826a81f8/gdp-life-exp-2007.csv');
continents = unique(gdpLifeExp.continent);

ax = axes();

hold on
for i=1:length(continents)
    rows = (strcmp(gdpLifeExp.continent, continents{i}));
    subtab = gdpLifeExp(rows,:);
    scatter(ax, subtab.gdpPerCapita, subtab.lifeExpectancy,...
        subtab.population/100000, [rand,rand,rand], 'filled',...
        'DisplayName', continents{i});
end
hold off

set(ax, 'xscale', 'log');

xlabel(ax,'gdp per capita');
ylabel(ax,'life expectancy');
legend(ax, continents);

shg

fig = fig2plotly(gcf);

response = plotlyoffline(fig);
web(response, '-browser');