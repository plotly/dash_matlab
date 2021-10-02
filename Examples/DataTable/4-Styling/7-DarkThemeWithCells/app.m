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
    'style_header', struct(...
        'backgroundColor', 'rgb(30, 30, 30)'),...
    'style_cell', struct(...
        'backgroundColor', 'rgb(50, 50, 50)',...
        'color', 'white'));

% Run the app
startDash(uiGrid, 8057);