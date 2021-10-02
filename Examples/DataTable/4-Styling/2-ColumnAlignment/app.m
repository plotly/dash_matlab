terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', true);
data = data((1:6),(1:5)); % Select first 6 rows and 5 columns

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

style_cell_conditional = {1};
style_cell_conditional{1} = struct(...
    'if', struct('column_id', 'Classification'),...
    'textAlign', 'right');

style_cell_conditional = {style_cell_conditional};

dataTable.UserData = struct(...
    'style_cell', struct(...
        'textAlign', 'left'),...
    'style_cell_conditional', style_cell_conditional);

% Run the app
startDash(uiGrid, 8057);