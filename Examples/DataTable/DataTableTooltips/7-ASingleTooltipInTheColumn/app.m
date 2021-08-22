clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);
try
    data = data([1:3],:); % Select first 3 rows
catch
end

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[~, lncols] = size(uit.Data);

tooltip = py.dict();
for i=1:lncols
    col = string(data.Properties.VariableNames(i));
    update(tooltip, py.dict(pyargs(col, py.dict(pyargs('value',col,'use_with','both')))));
end

uit.UserData = struct(...
    'tooltip', tooltip,...
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