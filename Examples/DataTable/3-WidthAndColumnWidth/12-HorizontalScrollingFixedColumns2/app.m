clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);

data = data([1:3],:); % Select first 3 rows

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

uit.UserData = struct(...
    'fixed_columns', struct(...
        'headers', true, 'data', 1),...
    'style_table', struct(...
        'minWidth', '100%'),...
    'style_cell', struct(...
        'minWidth', '180px', 'width', '180px', 'maxWidth', '180px',...
        'overflow', 'hidden',...
        'textOverflow', 'ellipsis'));

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))