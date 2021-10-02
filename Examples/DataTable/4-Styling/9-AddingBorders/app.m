terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', true);
data = data((1:6),(1:7)); % Select first 6 rows and 7 columns

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

dataTable.UserData = struct(...
    'style_data', struct(...
        'border', '1px solid blue'),...
    'style_header', struct(...
        'border', '1px solid pink'));

% Run the app
startDash(uiGrid, 8057);