terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/JgqCd', 'PreserveVariableNames', true);

data.index = (1:1:height(data))'; % Add index column
data.Properties.VariableNames{end} = 'Aindex';
data = data(:, sort(data.Properties.VariableNames));

PAGE_SIZE = 5;

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table-paging-and-sorting');

% Define columns
lncols = width(dataTable.Data);
columns = {lncols};
for i=1:lncols
    col = data.Properties.VariableNames{i};
    columns{i} = struct('name', col, 'id', col, 'deletable', true);
end
columns = {columns};

dataTable.UserData = struct(...
    'columns', columns,...
    'page_current', 0,...
    'page_size', PAGE_SIZE,...
    'page_action', 'custom',...
    'sort_action', 'custom',...
    'sort_mode', 'single',...
    'sort_by', {{}});

% Callback
args = {...
    argsOut('table-paging-and-sorting','data'),...
    argsIn('table-paging-and-sorting','page_current'),...
    argsIn('table-paging-and-sorting','page_size'),...
    argsIn('table-paging-and-sorting','sort_by')};
handle = 'update_table';
callbackDat = {args, handle};

% Run the app
startDash(uiGrid, 8057, callbackDat);