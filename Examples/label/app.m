terminate(pyenv);

% create Dash app
label_app = createApp();

% add boxes to Dash app layout
uifig = uifigure('visible', 'off');

label_1 = uilabel(uifig);
label_1.Text = 'This is Label 1';
dash_label1 = ui2dash(label_1, 'label_1');


% add label to Dash app layout
label_app.layout = addLayout(py.dash_html_components.Div(...
    dash_label1));

% run the app

label_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
