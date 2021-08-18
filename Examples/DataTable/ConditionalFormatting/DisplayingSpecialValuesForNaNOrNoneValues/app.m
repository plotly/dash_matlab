clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm3.csv', 'PreserveVariableNames', true);
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

[lnrows, lncols] = size(uit.Data);
customColumns = {lncols};
for i=1:lncols
    col = string(data.Properties.VariableNames(i));
    customColumns{i} = py.dict(pyargs('name', col,...
        'id', col,...
        'type', 'numeric',...
        'format', py.dash_table.Format.Format(pyargs('nully','N/A'))));
end
customColumns = py.list(customColumns);

uit.UserData = struct(...
    'customColumns', customColumns,...
    'editable', true);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))