terminate(pyenv);

% create Dash app
gauge_app = createApp();

uifig = uifigure('visible', 'off');

% Gauge
g = uigauge(uifig);
g.Value = 5; % Starting Value
g.Limits = [0 16]; % Min and Max
g.ScaleColors = {'green','yellow','red'}; % This transforms to n-by-3 array of RGB triplets: [0 0 1; 1 1 0]
g.ScaleColorLimits = [0 5; 5 12; 12 16];
dash_gauge = ui2dash(g, 'my-gauge');

% Slider
sld = uislider(uifig);
sld.Value = g.Value;
sld.MajorTicks = [g.Limits(1):1:g.Limits(2)];
dash_sld = ui2dash(sld, 'my-gauge-slider');

% add gauge and slider to Dash app layout
gauge_app.layout = addLayout(py.dash_html_components.Div({...
    dash_gauge, dash_sld}));

% define the callbacks

% define the callbacks

gauge_callback = gauge_app.callback({...
    argsOut('my-gauge', 'value'),...
    argsIn('my-gauge-slider','value')});  

gauge_callback(@py.callback.callback);

% run the app

gauge_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
