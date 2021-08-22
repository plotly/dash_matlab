clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);
try
    data = data([1:8],:); % Select first 8 rows
catch
end

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[lnrows, lncols] = size(uit.Data);
tooltip_data = {lnrows};
for i=1:lnrows
    d = py.dict();
    for j=1:lncols
        update(d, py.dict(pyargs(string(uit.ColumnName(j)), py.dict(pyargs(...
            'value', string(uit.Data{i,j}), 'type', 'markdown')))));
    end
    tooltip_data{i} = d;
end
tooltip_data = py.list(tooltip_data);

css = {1};
css{1} = struct(...
    'selector','.dash-table-tooltip',...
    'rule','background-color: gray; font-family: monospace;');
css = py.list(css);

uit.UserData = struct(...
    'tooltip_data', tooltip_data,...
    'css', css,...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))