clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv');

data = data([1:3],:); % Select first 3 rows

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[~, lncols] = size(uit.Data);

tooltip_header = struct();
for i=1:lncols
    fld = string(uit.ColumnName(i));
    tooltip_header.(fld) = fld;
    %update(tooltip_header, py.dict(pyargs(string(uit.ColumnName(i)), string(uit.ColumnName(i)))));
end

uit.UserData = struct(...
    'tooltip_header', tooltip_header,...
    'style_header', struct(...
        'textDecoration','underline',...
        'textDecorationStyle','dotted'),...
    'style_cell', struct(...
        'overflow','hidden',...
        'textOverflow','ellipsis',...
        'maxWidth',0),...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))