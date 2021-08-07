terminate(pyenv);

% create Dash app
textArea_app = createApp();

% add text area to Dash app layout
uifig = uifigure('visible', 'off');

txt1 = uitextarea(uifig);
%txt1.Value = sprintf('Textarea content initialized\nwith multiple lines of text')
txt1.Value = sprintf('Line1\nLine2\nLine3');
%txt1.Value = sprintf('%s\n%s', 'Line 1', 'Line 2')
dash_txt1 = ui2dash(txt1, 'textarea-example');

dash_txt = py.dash_html_components.Div(pyargs(...
    'id', 'textarea-example-output',...
    'style', py.dict(pyargs('whiteSpace', 'pre-line'))));

%dash_txt = py.dash_html_components.Div(...
%    'id', 'textarea-example-output');

% add txt area and text below to Dash app layout
textArea_app.layout = addLayout(py.dash_html_components.Div({...
    dash_txt1, dash_txt}));

% define the callbacks

txt_callback = textArea_app.callback( {argsOut('textarea-example-output', 'children'),...
    argsIn('textarea-example','value')}); 

txt_callback(@py.callback.callback);

% run the app

textArea_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
