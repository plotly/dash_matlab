clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm3.csv', 'PreserveVariableNames', true);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[~, lncols] = size(data);

style_data_conditional = {lncols};

for i=1:lncols
    col = string(data.Properties.VariableNames(i));
    style_data_conditional{i} = struct(...
        'if', struct('filter_query', sprintf('{%s} is blank', col),...
            'column_id', col),...
        'backgroundColor', 'tomato',...
        'color', 'white'); 
end
style_data_conditional = {style_data_conditional};

uit.UserData = struct(...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))