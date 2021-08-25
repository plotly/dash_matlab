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

style_cell_conditional = {3};
style_cell_conditional{1} = struct(...
    'if', struct('column_id', 'Provider City'),...
    'width', '130px');
style_cell_conditional{2} = struct(...
    'if', struct('column_id', 'DRG'),...
    'width', '130px');
style_cell_conditional{3} = struct(...
    'if', struct('column_id', 'Hospital Referral Region Description'),...
    'width', '130px');

style_cell_conditional = {style_cell_conditional};

uit.UserData = struct(...
    'style_cell_conditional', style_cell_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))