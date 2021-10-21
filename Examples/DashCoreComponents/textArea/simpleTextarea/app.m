terminate(pyenv);
clearvars;

% Add text area to Dash app layout
uiFig = uifigure('visible', 'off');

txt1 = uitextarea(uiFig);
txt1.Value = sprintf('Textarea content initialized\nwith multiple lines of text');
dashTxt1 = ui2dash(txt1, 'textarea-example');

dashTxt = Html('Div', {'id', 'textarea-example-output',...
    'style', struct('whiteSpace', 'pre-line')});

% Add txt area and text below to Dash app layout
components = {dashTxt1, dashTxt};

% Define the callbacks
args = { ...
    argsOut('textarea-example-output', 'children'),...
    argsIn('textarea-example','value')};
handle = 'update_output';

callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');
