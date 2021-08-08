terminate(pyenv);

% create Dash app
link_app = createApp();

% add boxes to Dash app layout
uifig = uifigure('visible', 'off');

link_1 = uihyperlink(uifig);
link_1.URL = 'https://plotly.com/';
link_1.Text = 'Welcome to Plotly!';
dash_link1 = ui2dash(link_1, 'link_1');


% add label to Dash app layout
link_app.layout = addLayout(py.dash_html_components.Div(...
    dash_link1));

% run the app

link_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
