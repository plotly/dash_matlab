clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm1.csv', 'PreserveVariableNames', true);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

style_data_conditional = {1};
style_data_conditional{1} = struct(...
    'if', struct('filter_query', '{Date} datestartswith "2015"'),...
    'backgroundColor', '#85144b',...
    'color', 'white');
style_data_conditional = {style_data_conditional};

[~, lncols] = size(uit.Data);
columns = {lncols};
for i=1:lncols
    col = data.Properties.VariableNames{i};
    if ~strcmp(col, 'Date')
        columns{i} = struct('name', col, 'id', col);
    else
        columns{i} = struct('name', 'Date', 'id', 'Date', 'type', 'datetime');
    end
end
columns = {columns};

uit.UserData = struct(...
    'columns', columns,...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))