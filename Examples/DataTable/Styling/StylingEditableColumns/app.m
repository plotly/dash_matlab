clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);
try
    data = data([1:6],[1:7]); % Select first 6 rows and first 7 columns
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
    'if', struct('column_editable', false),...
    'backgroundColor', 'rgb(30, 30, 30)',...
    'color', 'white');
style_data_conditional = py.list(style_data_conditional);

style_header_conditional = {1};
style_header_conditional{1} = struct(...
    'if', struct('column_editable', false),...
    'backgroundColor', 'rgb(30, 30, 30)',...
    'color', 'white');
style_header_conditional = py.list(style_header_conditional);

[lnrows, lncols] = size(uit.Data);
customColumns = {lncols};
customColumns{1} = py.dict(pyargs('name', 'City, State', 'id', 'City, State'));
customColumns{2} = py.dict(pyargs('name', 'Classification', 'id', 'Classification'));
customColumns{3} = py.dict(pyargs('name', 'Definition', 'id', 'Definition'));
customColumns{4} = py.dict(pyargs('name', 'DRG', 'id', 'DRG', 'editable', true));
customColumns{5} = py.dict(pyargs('name', 'Hospit Reg Descr', 'id', 'Hospital Referral Region Description'));
customColumns{6} = py.dict(pyargs('name', 'Prov City', 'id', 'Provider City'));
customColumns{7} = py.dict(pyargs('name', 'Prov Id', 'id', 'Provider Id'));

customColumns = py.list(customColumns);


uit.UserData = struct(...
    'customColumns', customColumns,...
    'style_data_conditional', style_data_conditional,...
    'style_header_conditional', style_header_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))