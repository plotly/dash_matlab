clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);
try
    data = data([1:6],:); % Select first 6 rows
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

style_cell_conditional = {3};
style_cell_conditional{1} = struct(...
    'if', struct('column_id', 'Provider City'),...
    'width', '130px');
style_cell_conditional{2} = struct(...
    'if', struct('column_id', 'DRG'),...
    'width', '130px');
style_cell_conditional{3} = struct(...
    'if', struct('column_id', 'Hospital Referral Region Description'),...
    'width', '130px');

style_cell_conditional = py.list(style_cell_conditional);

uit.UserData = struct(...
    'style_cell_conditional', style_cell_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))