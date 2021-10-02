terminate(pyenv);
clearvars;

% Data
data = table;

for n=1:15
    colName = strcat('Column_', num2str(n));
    data.(colName) = (0:1:29)';
end

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

dataTable.UserData = struct(...
    'fixed_rows', struct(...
        'headers', true));

% Run the app
startDash(uiGrid, 8057);