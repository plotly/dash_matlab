terminate(pyenv);

% create Dash app
lamp_app = createApp();

uifig = uifigure('visible', 'off');

% Lamp (daq indicator)
l = uilamp(uifig);
l.Color = "#551A8B";
dash_lamp = ui2dash(l, 'my-indicator');

% Button
btn = uibutton(uifig);
btn.Text = 'On/Off';
dash_button = ui2dash(btn, 'my-indicator-button');

% add lamp and button to Dash app layout
lamp_app.layout = addLayout(dash_lamp, dash_button);

% define the callbacks

lamp_callback = lamp_app.callback({...
    argsOut('my-indicator', 'value'),...
    argsIn('my-indicator-button','n_clicks')});  

lamp_callback(@py.callback.callback);

% run the app

lamp_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
