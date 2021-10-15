terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

btn1 = uibutton('Text', 'Button 1');
dashButton1 = ui2dash(btn1, 'btn_1');

btn2 = uibutton('Text', 'Button 2');
dashButton2 = ui2dash(btn2, 'btn_2');

btn3 = uibutton('Text', 'Button 3');
dashButton3 = ui2dash(btn3, 'btn_3');

dashText = Html('Div', {'id','container'});

% Add buttons and text below to Dash app layout
components = {dashButton1, dashButton2, dashButton3, dashText};

% Define the callbacks
args = {...
    argsOut('container', 'children'),...
    argsIn('btn_1','n_clicks'),...
    argsIn('btn_2','n_clicks'),...
    argsIn('btn_3','n_clicks')};

handle = 'displayCallback';

callbackDat = {args, handle};

% Run the app.
startDash(components, 8057, callbackDat, 'DARKLY');
