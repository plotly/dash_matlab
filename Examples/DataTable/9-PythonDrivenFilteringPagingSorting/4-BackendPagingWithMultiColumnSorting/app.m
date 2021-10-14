terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/JgqCd', 'PreserveVariableNames', true);

data = data(:, sort(data.Properties.VariableNames));

PAGE_SIZE = 5;

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table-multicol-sorting');

dataTable.UserData = struct(...
    'page_current', 0,...
    'page_size', PAGE_SIZE,...
    'page_action', 'custom',...
    'sort_action', 'custom',...
    'sort_mode', 'multi',...
    'sort_by', {{}});

% Callbacks
args = {...
    argsOut('table-multicol-sorting','data'),...
    argsIn('table-multicol-sorting','page_current'),...
    argsIn('table-multicol-sorting','page_size'),...
    argsIn('table-multicol-sorting','sort_by')};
handle = 'update_table';
callbackDat = {args, handle};

% Run the app
startDash(uiGrid, 8057, callbackDat);