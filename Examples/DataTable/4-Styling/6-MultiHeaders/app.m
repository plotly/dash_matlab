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

lncols = height(dataTable);
columns = {lncols};
columns{1} = struct('name', {{'','City, State'}}, 'id', 'City, State');
columns{2} = struct('name', {{'Props1','Classification'}}, 'id', 'Classification');
columns{3} = struct('name', {{'Props1','Definition'}}, 'id', 'Definition');
columns{4} = struct('name', {{'Props1','DRG'}}, 'id', 'DRG');
columns{5} = struct('name', {{'Props1','Hospit Reg Descr'}}, 'id', 'Hospital Referral Region Description');
columns{6} = struct('name', {{'Providers','Prov City'}}, 'id', 'Provider City');
columns{7} = struct('name', {{'Providers','Prov Id'}}, 'id', 'Provider Id');
columns = {columns};

dataTable.UserData = struct(...
    'columns', columns,...
    'merge_duplicate_headers', true);

% Run the app
startDash(uiGrid, 8057);