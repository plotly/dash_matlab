clear all
close all
terminate(pyenv);

all_inds = {'New York City'; 'Montreal'; 'San Francisco'};
% create Dash app

dropdown_app = createApp();

% create ui elements

uifig = uifigure('visible', 'off');

dropd1 = uidropdown(uifig, 'Items', all_inds, 'Value', all_inds{1});

dash_dropd1 = ui2dash(dropd1, 'demo-dropdown');

dash_txt = py.dash_html_components.Div('id','dd-output-container');

% add dropdown to Dash app layout

dropdown_app.layout = addLayout(py.dash_html_components.Div({...
    dash_dropd1, dash_txt}));

% define the callbacks

slider_callback = dropdown_app.callback({ ...
    argsOut('dd-output-container', 'children'), ...
    argsIn('demo-dropdown', 'value') });  
slider_callback(@py.callback.callback);

% run the app

dropdown_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))