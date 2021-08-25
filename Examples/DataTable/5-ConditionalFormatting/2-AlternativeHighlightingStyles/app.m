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

style_data_conditional = {2};
style_data_conditional{1} = struct(...
    'if', struct('filter_query', '{Humidity} > 19 && {Humidity} < 41',...
        'column_id', 'Humidity'),...
    'color', 'tomato',...
    'fontWeight', 'bold');
style_data_conditional{2} = struct(...
    'if', struct('filter_query', '{Pressure} > 19',...
        'column_id', 'Pressure'),...
    'textDecoration', 'underline');
style_data_conditional = {style_data_conditional};


uit.UserData = struct(...
    'sort_action', 'native',...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))