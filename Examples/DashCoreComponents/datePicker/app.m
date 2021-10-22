terminate(pyenv);

% create Dash app
date_app = createApp();

uifig = uifigure('visible', 'off');

date_def = uidatepicker(uifig);
date_def.DisplayFormat = 'M/d/yyyy';
date_def.Limits = [datetime('today') datetime(2050,1,1)];
dash_date = ui2dash(date_def, 'my-date-picker-single');

dash_txt = py.dash_html_components.Div('id','output-container-date-picker-single');

% add elements to Dash app layout
date_app.layout = addLayout(py.dash_html_components.Div({...
    dash_date, dash_txt}));

% define the callbacks

date_callback = date_app.callback( {...
    argsOut('output-container-date-picker-single', 'children'),...
    argsIn('my-date-picker-single','date')}); 

date_callback(@py.callback.callback);

% run the app

date_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
