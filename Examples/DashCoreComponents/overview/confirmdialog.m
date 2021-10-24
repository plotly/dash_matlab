terminate(pyenv);
clearvars;

dashDialog = Dcc('ConfirmDialog', {...
    'id', 'confirm',...
    'message', 'Danger danger! Are you sure you want to continue?'});

components = {dashDialog};

% Start app
startDash(components, 8057, [], 'SOLAR');