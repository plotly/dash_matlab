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

dash_table = ui2dash(uit, 'datatable-paging-page-count'); % Id of datatable is defined here

br = py.dash_html_components.Br();

checklist = py.dash_core_components.Checklist(pyargs(...
    'id', 'datatable-use-page-count',...
    'options', py.list({struct(...
        'label', 'Use page_count', 'value', 'True')}),...
    'value', py.list({'True'})));

input = py.dash_core_components.Input(pyargs(...
    'id', 'datatable-page-count',...
    'type', 'number',...
    'min', 1,...
    'max', 29,...
    'value', 20));

% add table to Dash app layout
table_app.layout = addLayout(py.dash_html_components.Div({...
    dash_table, br, checklist, 'Page count: ', input}));

% Callbacks

table_callback1 = table_app.callback({argsOut('datatable-paging-page-count','data'),...
    argsIn('datatable-paging-page-count','page_current'),...
    argsIn('datatable-paging-page-count','page_size')});
table_callback1(@py.callback.callback1);

table_callback2 = table_app.callback({argsOut('datatable-paging-page-count','page_count'),...
    argsIn('datatable-use-page-count','value'),...
    argsIn('datatable-page-count','value')});
table_callback2(@py.callback.callback2);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))