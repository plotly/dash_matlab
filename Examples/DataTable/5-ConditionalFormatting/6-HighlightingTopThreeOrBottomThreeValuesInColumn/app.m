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

style_data_conditional = {6};

maxTemp = maxk(data.Temperature,3); % Find 3 maximums
for i=1:length(maxTemp)
    style_data_conditional{i}  = struct(...
        'if', struct('filter_query', sprintf('{Temperature} = %d', maxTemp(i)),...
        'column_id', 'Temperature'),...
        'backgroundColor', '#0074D9',...
        'color', 'white');
end

minPress = mink(data.Pressure,3); % Find 3 minimums
for i=1:length(minPress)
    style_data_conditional{i+3}  = struct(...
        'if', struct('filter_query', sprintf('{Pressure} = %d', minPress(i)),...
        'column_id', 'Pressure'),...
        'backgroundColor', '#7FDBFF',...
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