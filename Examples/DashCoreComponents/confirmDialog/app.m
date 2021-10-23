terminate(pyenv);
clearvars;

dashDialog = Dcc('ConfirmDialog', {...
    'id', 'confirm-danger',...
    'message', 'Danger danger! Are you sure you want to continue?'});

dashDropdown = Dcc('Dropdown', {...
    'options', {...
        struct('label','Safe','value','Safe'),...
        struct('label','Danger!!','value','Danger!!')},...
    'id', 'dropdown-danger'});

dashDiv = Html('Div', {'id', 'output-danger'});

components = {dashDialog, dashDropdown, dashDiv};

% Callbacks
args1 = {argsOut('confirm-danger', 'displayed'), ...
    argsIn('dropdown-danger', 'value') };
handle1 = 'display_confirm';
callbackDat = {args1, handle1};

args2 = {argsOut('output-danger', 'children'), ...
    argsIn('confirm-danger', 'submit_n_clicks') };
handle2 = 'update_output';
callbackDat{2,1} = args2;
callbackDat{2,2} = handle2;

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');