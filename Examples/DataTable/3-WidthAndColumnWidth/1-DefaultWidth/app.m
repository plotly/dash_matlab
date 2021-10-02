terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgv9Q', 'PreserveVariableNames', true);

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

% Define struct which stores uitable properties like styling
dataTable.UserData = struct();

% Run the app
startDash(uiGrid, 8057);