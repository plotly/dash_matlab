terminate(pyenv);
clearvars;

% Add text area to Dash app layout
uiFig = uifigure('visible', 'off');

txt1 = uitextarea(uiFig);
txt1.Value = sprintf('Textarea content initialized\nwith multiple lines of text');
dashTextArea = ui2dash(txt1, 'textarea-state-example');

btn1 = uibutton(uiFig);
btn1.Text = 'Submit';
dashButton = ui2dash(btn1, 'textarea-state-example-button');

dashTxt = Html('Div', {'id', 'textarea-state-example-output',...
    'style', struct('whiteSpace', 'pre-line')});

% Add txt area and text below to Dash app layout
components = {dashTextArea, dashButton, dashTxt};

% Define the callbacks
args = { ...
    argsOut('textarea-state-example-output', 'children'),...
    argsIn('textarea-state-example-button', 'n_clicks'),...
    argState('textarea-state-example', 'value')};
handle = 'update_output';

callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');
