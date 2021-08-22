clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminder2007.csv', 'PreserveVariableNames', true);

data.index = [1:1:height(data)]';
data = movevars(data, 'index', 'Before', 'country');

PAGE_SIZE = 5;
% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');

uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

uit.UserData = struct(...
    'page_current', 0,...
    'page_size', PAGE_SIZE,...
    'page_action', 'custom');

dash_table = ui2dash(uit, 'datatable-paging'); % Id of datatable is defined here

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% Callbacks

table_callback = table_app.callback({argsOut('datatable-paging','data'),...
    argsIn('datatable-paging','page_current'),...
    argsIn('datatable-paging','page_size')});

table_callback(@py.callback.callback);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))