clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);
try
    data = data([1:7],:); % Select first 7 rows
catch
end

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

tooltip_conditional = {1};
tooltip_conditional{1} = struct(...
    'if', struct('filter_query','{Provider Name} contains "HOSPITAL"'),...
    'type','markdown',...
    'value','This row is significant.');
tooltip_conditional = py.list(tooltip_conditional);

style_data_conditional = {1};
style_data_conditional{1} = struct(...
    'if', struct('filter_query','{Provider Name} contains "HOSPITAL"'),...
    'backgroundColor','#0074D9',...
    'color','white',...
    'textDecoration','underline',...
    'textDecorationStyle','dotted');
style_data_conditional = py.list(style_data_conditional);

uit.UserData = struct(...
    'tooltip_conditional', tooltip_conditional,...
    'style_data_conditional', style_data_conditional,...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))