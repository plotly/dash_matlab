clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm3.csv', 'PreserveVariableNames', true);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[~, lncols] = size(uit.Data);
columns = {lncols};
for i=1:lncols
    col = string(data.Properties.VariableNames(i));
    columns{i} = struct('name', col,...
        'id', col,...
        'type', 'numeric',...
        'format', py.dash_table.Format.Format(pyargs('nully','N/A')));
end
columns = {columns};

uit.UserData = struct(...
    'columns', columns,...
    'editable', true);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))