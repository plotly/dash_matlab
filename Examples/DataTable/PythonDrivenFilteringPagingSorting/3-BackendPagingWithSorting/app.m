clear all
close all
terminate(pyenv);

% read data file

data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminder2007.csv', 'PreserveVariableNames', true);

data.index = [1:1:height(data)]'; % Add index column
data.Properties.VariableNames{end} = 'Aindex'; % Add space to index name
data = data(:, sort(data.Properties.VariableNames));

PAGE_SIZE = 5;

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');

uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

% Define columns
[lnrows, lncols] = size(uit.Data);
customColumns = {lncols};
for i=1:lncols
    col = data.Properties.VariableNames{i};
    customColumns{i} = struct('name', col, 'id', col, 'deletable', true);
end
customColumns = {customColumns};

uit.UserData = struct(...
    'customColumns', customColumns,...
    'page_current', 0,...
    'page_size', PAGE_SIZE,...
    'page_action', 'custom',...
    'sort_action', 'custom',...
    'sort_mode', 'single',...
    'sort_by', py.list({}));

dash_table = ui2dash(uit, 'table-paging-and-sorting'); % Id of datatable is defined here

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% Callbacks

table_callback = table_app.callback({argsOut('table-paging-and-sorting','data'),...
    argsIn('table-paging-and-sorting','page_current'),...
    argsIn('table-paging-and-sorting','page_size'),...
    argsIn('table-paging-and-sorting','sort_by')});

table_callback(@py.callback.callback);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))