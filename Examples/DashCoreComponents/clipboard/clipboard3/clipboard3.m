terminate(pyenv);
clearvars;

dashClipboard = Dcc('Clipboard', {...
    'id', 'table_copy',...
    'style', struct('fontSize', 20)});

data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/solar.csv', 'PreserveVariableNames', true);

uiFigure = uifigure('visible', 'off');
dataTable = uitable(uiFigure, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off');
dataTable.UserData = struct('page_size', 10);

dashTable = ui2dash(dataTable, 'table_cb');

components = {dashClipboard, dashTable};

% Callbacks
args = {argsOut('table_copy', 'content'),...
    argsIn('table_copy', 'n_clicks'),...
    argState('table_cb', 'data')};
handle = 'custom_copy';
callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');