clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);

data = data([1:10],[1:7]); % Select first 10 rows and first 7 columns

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[~, lncols] = size(uit.Data);
columns = {lncols};
columns{1} = struct('name', {{'','City, State'}}, 'id', 'City, State');
columns{2} = struct('name', {{'Props1','Classification'}}, 'id', 'Classification');
columns{3} = struct('name', {{'Props1','Definition'}}, 'id', 'Definition');
columns{4} = struct('name', {{'Props1','DRG'}}, 'id', 'DRG');
columns{5} = struct('name', {{'Props1','Hospit Reg Descr'}}, 'id', 'Hospital Referral Region Description');
columns{6} = struct('name', {{'Providers','Prov City'}}, 'id', 'Provider City');
columns{7} = struct('name', {{'Providers','Prov Id'}}, 'id', 'Provider Id');
columns = {columns};

uit.UserData = struct(...
    'columns', columns,...
    'merge_duplicate_headers', true);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))