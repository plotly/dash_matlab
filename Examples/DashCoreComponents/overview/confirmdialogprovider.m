terminate(pyenv);
clearvars;

dashDialog = Dcc('ConfirmDialogProvider', {...
    'children', Html('Button', {'Click Me'})...
    'id', 'danger-danger',...
    'message', 'Danger danger! Are you sure you want to continue?'});

components = {dashDialog};

% Start app
startDash(components, 8057, [], 'SOLAR');