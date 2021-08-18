terminate(pyenv);

% create Dash app
knob_app = createApp();

uifig = uifigure('visible', 'off');

% Knob
k = uiknob(uifig);
k.Value = 3; % Starting Value
k.Limits = [0 16]; % Min and Max
dash_knob = ui2dash(k, 'my-knob');

% Output text
dash_txt = py.dash_html_components.Div('id','knob-output');

% add knob and text to Dash app layout
knob_app.layout = addLayout(py.dash_html_components.Div({...
    dash_knob, dash_txt}));

% define the callbacks

knob_callback = knob_app.callback({...
    argsOut('knob-output', 'children'),...
    argsIn('my-knob','value')});  

knob_callback(@py.callback.callback);

% run the app

knob_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
