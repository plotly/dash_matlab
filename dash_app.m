terminate(pyenv);

% read data file

tab = readtable('dat.csv');

% create Dash app

app = createApp();

% create slider

uifig = uifigure('visible', 'off');
sld = uislider(uifig);
dash_sld = ui2dash(sld, 'years')

% create graph

fig = figure('visible', 'off');
YEAR = 1952;
rows = (tab.year == YEAR);
subtab = tab(rows,:);
scatter(subtab.gdpPercap, ...
    subtab.lifeExp, ...
    subtab.pop/1000000, ...
    categorical(subtab.country), 'filled');
 set(gca,'xscale','log');
 fig = plotlyfig2dash(fig2plotly(gcf, 'offline', true, 'open', false));
 
% add slider and graph to Dash app layout

app.layout = addLayout(fig, dash_sld)

% run the app

app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
