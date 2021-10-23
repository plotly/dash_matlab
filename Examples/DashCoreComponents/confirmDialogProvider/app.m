terminate(pyenv);
clearvars;

dashDialog = Dcc('ConfirmDialogProvider', {...
    'children', Html('Button', {'Click Me'})...
    'id', 'danger-danger-provider',...
    'message', 'Danger danger! Are you sure you want to continue?'});

dashDiv = Html('Div', {'id', 'output-provider'});

components = {dashDialog, dashDiv};

% Callbacks
args = {argsOut('output-provider', 'children'), ...
    argsIn('danger-danger-provider', 'submit_n_clicks') };
handle = 'update_output';
callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');