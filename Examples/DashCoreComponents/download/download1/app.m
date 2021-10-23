terminate(pyenv);
clearvars;

dashButton = Html('Button', {'Download Text', 'id', 'btn-download-txt'});

dashDownload = Dcc('Download', {'id', 'download-text'});

components = {dashButton, dashDownload};

% Callbacks
args = {argsOut('download-text', 'dara'),...
    argsIn('btn-download-txt', 'n_clicks'),...
    true};
handle = 'update_output';
callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');