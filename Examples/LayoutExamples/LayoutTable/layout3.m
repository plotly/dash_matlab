terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Read data file
data = readtable('https://gist.githubusercontent.com/chriddyp/c78bf172206ce24f77d6363a2d754b59/raw/c353e8ef842413cae56ae3920b8fd78468aa4cb2/usa-agricultural-exports-2011.csv', 'PreserveVariableNames', true);

% Create Dash app
app = createApp();

uiFigure = uifigure('visible', 'off');
uiGrid = uigridlayout(uiFigure);

% Title
title = uilabel(uiGrid, 'Text', 'US Agriculture Exports (2011)',...
    'FontSize', 24, 'FontWeight', 'bold');

table = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');
table.UserData = struct('page_size', 10);
table.Tag = 'my-table';

% Run the app.
layoutApp = startDash(uiGrid, 8057);