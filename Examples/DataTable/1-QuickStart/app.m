clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/solar.csv', 'PreserveVariableNames', true);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

% Define struct which stores uitable properties like styling
uit.UserData = struct();

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout

table_app.layout = addLayout(dash_table);

% run the app

table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))