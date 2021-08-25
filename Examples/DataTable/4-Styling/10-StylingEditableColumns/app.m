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

style_data_conditional = {1};
style_data_conditional{1} = struct(...
    'if', struct('column_editable', false),...
    'backgroundColor', 'rgb(30, 30, 30)',...
    'color', 'white');
style_data_conditional = {style_data_conditional};

style_header_conditional = {1};
style_header_conditional{1} = struct(...
    'if', struct('column_editable', false),...
    'backgroundColor', 'rgb(30, 30, 30)',...
    'color', 'white');
style_header_conditional = {style_header_conditional};

[~, lncols] = size(uit.Data);
columns = {lncols};
columns{1} = struct('name', 'City, State', 'id', 'City, State');
columns{2} = struct('name', 'Classification', 'id', 'Classification');
columns{3} = struct('name', 'Definition', 'id', 'Definition');
columns{4} = struct('name', 'DRG', 'id', 'DRG', 'editable', true);
columns{5} = struct('name', 'Hospit Reg Descr', 'id', 'Hospital Referral Region Description');
columns{6} = struct('name', 'Prov City', 'id', 'Provider City');
columns{7} = struct('name', 'Prov Id', 'id', 'Provider Id');
columns = {columns};

uit.UserData = struct(...
    'columns', columns,...
    'style_data_conditional', style_data_conditional,...
    'style_header_conditional', style_header_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))