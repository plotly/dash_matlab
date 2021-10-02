terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/JgqCd', 'PreserveVariableNames', true);

data.index = (1:1:height(data))';
data = movevars(data, 'index', 'Before', 'country');

PAGE_SIZE = 5;

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'datatable-paging');

dataTable.UserData = struct(...
    'page_current', 0,...
    'page_size', PAGE_SIZE,...
    'page_action', 'custom');

% Callbacks

args = {...
    argsOut('datatable-paging','data'),...
    argsIn('datatable-paging','page_current'),...
    argsIn('datatable-paging','page_size')};
handle = 'update_table';
callbackDat = {args, handle};

% Run the app
startDash(uiGrid, 8057, callbackDat);