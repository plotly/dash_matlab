clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm2.csv', 'PreserveVariableNames', true);

data.id = (0:height(data)-1).'; % Add index column, starting from 0

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[~, lncols] = size(uit.Data);

[maxRows, maxIn] = max(data{1:end,2:end-1},[],2);

style_data_conditional = {lncols-1};
for i=2:lncols-1
    style_data_conditional{i-1}  = struct(...
        'if', struct('filter_query', sprintf('{id} = %d', i-2),...
        'column_id', data.Properties.VariableNames(maxIn(i-1)+1)),...
        'backgroundColor', '#3D9970',...
        'color', 'white');
end

style_data_conditional = {style_data_conditional};

columns = {lncols-1};
for i=1:lncols-1
    columns{i} = struct('name', string(data.Properties.VariableNames(i)),...
        'id', string(data.Properties.VariableNames(i)));
end
columns = {columns};

uit.UserData = struct(...
    'sort_action', 'native',...
    'columns', columns,...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))