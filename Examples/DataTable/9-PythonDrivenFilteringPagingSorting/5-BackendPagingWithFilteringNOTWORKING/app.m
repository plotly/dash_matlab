clear all
close all
terminate(pyenv);

% read data file

data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminder2007.csv', 'PreserveVariableNames', true);

data = data(:, sort(data.Properties.VariableNames));

PAGE_SIZE = 5;

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');

uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

uit.UserData = struct(...
    'page_current', 0,...
    'page_size', PAGE_SIZE,...
    'page_action', 'custom',...
    'filter_action', 'custom',...
    'filter_query', '');

dash_table = ui2dash(uit, 'table-filtering'); % Id of datatable is defined here

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% Callbacks

table_callback = table_app.callback({argsOut('table-filtering','data'),...
    argsIn('table-filtering','page_current'),...
    argsIn('table-filtering','page_size'),...
    argsIn('table-filtering','filter_query')});

table_callback(@py.callback.callback);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))