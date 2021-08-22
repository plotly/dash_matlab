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

[lnrows, lncols] = size(uit.Data);

tooltip_header = py.dict();
update(tooltip_header, py.dict(pyargs('DRG','Diagnosis Related Group')));
update(tooltip_header, py.dict(pyargs('Provider City','Provider City Name')));
update(tooltip_header, py.dict(pyargs('Provider Id','Provider Identification (number)')));

style_header_conditional = {3};
style_header_conditional{1} = py.dict(pyargs(...
    'if',py.dict(pyargs('column_id','DRG')),...
    'textDecoration','underline',...
    'textDecorationStyle','dotted'));
style_header_conditional{2} = py.dict(pyargs(...
    'if',py.dict(pyargs('column_id','Provider City')),...
    'textDecoration','underline',...
    'textDecorationStyle','dotted'));
style_header_conditional{3} = py.dict(pyargs(...
    'if',py.dict(pyargs('column_id','Provider Id')),...
    'textDecoration','underline',...
    'textDecorationStyle','dotted'));
style_header_conditional = py.list(style_header_conditional);

uit.UserData = struct(...
    'tooltip_header', tooltip_header,...
    'style_header_conditional', style_header_conditional,...
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