terminate(pyenv);

% create Dash app
input_app = createApp();

uifig = uifigure('visible', 'off');

input = uieditfield(uifig);
input.Value = 'initial value';
input.Placeholder = 'Input: ';
dash_input = ui2dash(input, 'my-input');

dash_txt = py.dash_html_components.Div('id','my-output');

% add elements to Dash app layout
input_app.layout = addLayout(...
    py.dash_html_components.H6('Change the value in the text box to see callbacks in action!'),...
    dash_input,...
    py.dash_html_components.Br,...
    dash_txt);

% define the callbacks

input_callback = input_app.callback( {...
    argsOut('my-output', 'children'),...
    argsIn('my-input','value')}); 

input_callback(@py.callback.callback);

% run the app

input_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
