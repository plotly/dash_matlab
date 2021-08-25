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

[~, lncols] = size(data);

style_data_conditional = {2*(lncols-1)};
count = 0;
for i=4:lncols
    col = string(data.Properties.VariableNames(i));
    x = data{:,col};
    
    value = quantile(x, 0.1);
    count = count+1;
    style_data_conditional{count} = struct(...
        'if', struct('filter_query', sprintf('{%s} > %d', col, value),...
            'column_id', col),...
        'backgroundColor', '#3D9970',...
        'color', 'white');
    
    value = quantile(x, 0.5);
    count = count+1;
    style_data_conditional{count} = struct(...
        'if', struct('filter_query', sprintf('{%s} <= %d', col, value),...
            'column_id', col),...
        'backgroundColor', '#FF4136',...
        'color', 'white');
end
style_data_conditional = {style_data_conditional};


uit.UserData = struct(...
    'sort_action', 'native',...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))