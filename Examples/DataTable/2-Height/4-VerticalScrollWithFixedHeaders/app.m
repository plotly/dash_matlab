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
    'fixed_rows', struct(...
        'headers', true),...
    'style_table', struct(...
        'height', 400)); % Defaults to 500

% Run the app
startDash(uiGrid, 8057);