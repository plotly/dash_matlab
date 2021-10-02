terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', false);
data = data((1:6),:); % Select first 6 rows

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

style_cell_conditional = {2};
style_cell_conditional{1} = struct(...
    'if', struct('column_id', 'City_State'),...
    'width', '30%');
style_cell_conditional{2} = struct(...
    'if', struct('column_id', 'Classification'),...
    'width', '30%');

style_cell_conditional = {style_cell_conditional};

dataTable.UserData = struct(...
    'style_cell_conditional', style_cell_conditional);

% Run the app
startDash(uiGrid, 8057);