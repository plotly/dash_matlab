terminate(pyenv);

% create Dash app
button_app = createApp();

% add buttons to Dash app layout
uifig = uifigure('visible', 'off');

btn1 = uibutton(uifig);
btn1.Text = 'Button 1';
dash_button1 = ui2dash(btn1, 'btn_nclicks_1');

btn2 = uibutton(uifig);
btn2.Text = 'Button 2';
dash_button2 = ui2dash(btn2, 'btn_nclicks_2');

btn3 = uibutton(uifig);
btn3.Text = 'Button 3';
dash_button3 = ui2dash(btn3, 'btn_nclicks_3');

dash_txt = py.dash_html_components.Div('id','container-button-timestamp');

% add buttons and text below to Dash app layout
button_app.layout = addLayout(py.dash_html_components.Div({...
    dash_button1, dash_button2, dash_button3, dash_txt}));

% define the callbacks

button_callback = button_app.callback( {argsOut('container-button-timestamp', 'children'),...
    argsIn('btn_nclicks_1','n_clicks'),...
    argsIn('btn_nclicks_2','n_clicks'),...
    argsIn('btn_nclicks_3','n_clicks')}); 

button_callback(@py.callback.callback);

% run the app

button_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
