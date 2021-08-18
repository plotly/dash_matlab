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

style_data_conditional = {1};
style_data_conditional{1} = struct(...
    'if', struct('filter_query', '{Date} datestartswith "2015-10"'),...
    'backgroundColor', '#85144b',...
    'color', 'white');
style_data_conditional = py.list(style_data_conditional);

[lnrows, lncols] = size(uit.Data);
customColumns = {lncols};
for i=1:lncols
    col = data.Properties.VariableNames{i};
    if ~strcmp(col, 'Date')
        customColumns{i} = py.dict(pyargs('name', col, 'id', col));
    else
        customColumns{i} = py.dict(pyargs('name', 'Date', 'id', 'Date', 'type', 'datetime'));
    end
end
customColumns = py.list(customColumns);

uit.UserData = struct(...
    'customColumns', customColumns,...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))