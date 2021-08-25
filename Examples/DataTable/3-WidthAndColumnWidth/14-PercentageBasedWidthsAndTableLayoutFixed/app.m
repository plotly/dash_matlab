clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);

data = data([1:6],:); % Select first 6 rows

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

css = {1};
css{1} = struct(...
        'selector', 'table',...
        'rule', 'table-layout: fixed');
css = {css};

[~, lncols] = size(uit.Data);

uit.UserData = struct(...
    'css', css,...
    'style_cell', struct(...
        'width', sprintf('%f%', lncols),...
        'textOverflow', 'ellipsis',...
        'overflow', 'hidden'));

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))