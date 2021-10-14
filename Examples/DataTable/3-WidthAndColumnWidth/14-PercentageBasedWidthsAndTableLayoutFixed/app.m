terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', false);
data = data((1:6),(1:5)); % Select first 6 rows and 5 columns

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

css = {1};
css{1} = struct(...
        'selector', 'table',...
        'rule', 'table-layout: fixed');
css = {css};

lncols = height(dataTable);

dataTable.UserData = struct(...
    'css', css,...
    'style_cell', struct(...
        'width', sprintf('%f%', lncols),...
        'textOverflow', 'ellipsis',...
        'overflow', 'hidden'));

% Run the app
startDash(uiGrid, 8057);