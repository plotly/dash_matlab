clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/2016-weather-data-seattle.csv', 'PreserveVariableNames', true);
data = data([1:50],:); % Select first 50 rows
data.Date = string(data.Date); % Convert "Date" column to string

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

uit.UserData = struct(...
    'page_size', 20,...
    'style_table', struct(...
        'height', '300px',...
        'overflowY', 'auto'));

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))