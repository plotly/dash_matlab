terminate(pyenv);
clearvars;

% read data file
data = readtable('https://git.io/JgviF', 'PreserveVariableNames', true);
data = data((1:30),:); % Select first 30 rows
data.Date = string(data.Date); % Convert "Date" column to string

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

dataTable.UserData = struct(...
    'page_size', 20,...
    'style_table', struct(...
        'height', '300px',...
        'overflowY', 'auto'));

% Run the app
startDash(uiGrid, 8057);