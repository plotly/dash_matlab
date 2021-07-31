terminate(pyenv);

% read data file

tab = readtable('dat.csv');

% create Dash app

app = createApp();

% create slider

uifig = uifigure('visible', 'off');
sld = uislider(uifig);
sld.MajorTicks = [1952,1957,1962,1967,1972,1977,1982,1987,1992,1997,2002,2007];
dash_sld = ui2dash(sld, 'year')

% create initial graph using fig2plotly

fig = figure('visible', 'off');
YEAR = 1952;
rows = (tab.year == YEAR);
subtab = tab(rows,:);
scatter(subtab.gdpPercap, ...
    subtab.lifeExp, ...
    subtab.pop/1000000, ...
    categorical(subtab.country), 'filled');
 set(gca,'xscale','log');
 fig = plotlyfig2dash(fig2plotly(gcf, 'offline', true, 'open', false), 'graph');
 
% add slider and graph to Dash app layout

app.layout = addLayout(fig, dash_sld);

% define the callbacks

slider_callback = app.callback( {argsOut('graph', 'figure'), argsIn('year','value') });

% Python callback file
% Need to turn this Python function into a generic pass through function
% that calls user-defined MATLAB function through Python matlab.engine
% utility. Alternatively, if this does not work, could rewrite callback 
% function entirely in MATLAB: 
% https://github.com/plotly/dash/blob/dev/dash/dash.py#L990

slider_callback(@py.update_figure.update_figure);  

% run the app

app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
