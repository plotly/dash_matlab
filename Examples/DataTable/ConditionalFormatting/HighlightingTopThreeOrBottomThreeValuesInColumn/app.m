clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm1.csv', 'PreserveVariableNames', true);
try
    data = data([1:20],[1:7]); % Select first 20 rows and first 7 columns
catch
end

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

%% Define struct which stores uitable properties like styling
% An example with cell and header stylings,
% as well as page_size property is provided:
%{
uit.UserData = struct(...
    'style_cell', struct(...
        'page_size', 3,...
        'textAlign', 'center',...
        'backgroundColor', 'rgb(50,50,50)',...
        'color', 'white',...
        'font_size', '16px',...
        'padding', '5px'),...
    'style_header', struct(...
        'backgroundColor', 'rgb(30,30,30)',...
        'fontWeight', 'bold'),...
    'page_size', 10);
%}
%%

style_data_conditional = {6};

maxTemp = maxk(data.Temperature,3);
for i=1:length(maxTemp)
    style_data_conditional{i}  = struct(...
        'if', struct('filter_query', sprintf('{Temperature} = %d', maxTemp(i)),...
        'column_id', 'Temperature'),...
        'backgroundColor', '#0074D9',...
        'color', 'white');
end

minPress = mink(data.Pressure,3);
for i=1:length(minPress)
    style_data_conditional{i+3}  = struct(...
        'if', struct('filter_query', sprintf('{Pressure} = %d', minPress(i)),...
        'column_id', 'Pressure'),...
        'backgroundColor', '#7FDBFF',...
        'color', 'white');
end

style_data_conditional = py.list(style_data_conditional);

uit.UserData = struct(...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))