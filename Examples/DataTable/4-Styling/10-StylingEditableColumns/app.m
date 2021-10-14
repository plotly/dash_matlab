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

style_data_conditional = {1};
style_data_conditional{1} = struct(...
    'if', struct('column_editable', false),...
    'backgroundColor', 'rgb(30, 30, 30)',...
    'color', 'white');
style_data_conditional = {style_data_conditional};

style_header_conditional = {1};
style_header_conditional{1} = struct(...
    'if', struct('column_editable', false),...
    'backgroundColor', 'rgb(30, 30, 30)',...
    'color', 'white');
style_header_conditional = {style_header_conditional};

lncols = height(dataTable);
columns = {lncols};
columns{1} = struct('name', 'City, State', 'id', 'City, State');
columns{2} = struct('name', 'Classification', 'id', 'Classification');
columns{3} = struct('name', 'Definition', 'id', 'Definition');
columns{4} = struct('name', 'DRG', 'id', 'DRG', 'editable', true);
columns{5} = struct('name', 'Hospit Reg Descr', 'id', 'Hospital Referral Region Description');
columns{6} = struct('name', 'Prov City', 'id', 'Provider City');
columns{7} = struct('name', 'Prov Id', 'id', 'Provider Id');
columns = {columns};

dataTable.UserData = struct(...
    'columns', columns,...
    'style_data_conditional', style_data_conditional,...
    'style_header_conditional', style_header_conditional);

% Run the app
startDash(uiGrid, 8057);