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

[lnrows, lncols] = size(uit.Data);
tooltip_data = {lnrows};
for i=1:lnrows
    d = struct();
    for j=1:lncols
        fld = string(uit.ColumnName(j));
        d.(fld) = struct(...
            'value', string(uit.Data{i,j}), 'type', 'markdown');
    end
    tooltip_data{i} = d;
end

tooltip_data = {tooltip_data};

uit.UserData = struct(...
    'style_cell', struct(...
        'overflow', 'hidden',...
        'textOverflow', 'ellipsis',...
        'maxWidth', 0),...
    'tooltip_data', tooltip_data,...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))