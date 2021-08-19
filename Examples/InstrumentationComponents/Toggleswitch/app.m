terminate(pyenv);

% create Dash app
switch_app = createApp();

uifig = uifigure('visible', 'off');

% Toggle Switch
s = uiswitch(uifig, 'toggle');
s.Enable = 'on';
s.Orientation = 'vertical';
dash_switch = ui2dash(s, 'my-toggle-switch');

% Output text
dash_txt = py.dash_html_components.Div('id','toggle-switch-output');

% add switch and text to Dash app layout
switch_app.layout = addLayout(py.dash_html_components.Div({...
    dash_switch, dash_txt}));

% define the callbacks

switch_callback = switch_app.callback({...
    argsOut('toggle-switch-output', 'children'),...
    argsIn('my-toggle-switch','value')});  

switch_callback(@py.callback.callback);

% run the app

switch_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
