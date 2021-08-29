clear all
close all
terminate(pyenv);

% create Dash app
table_app = createApp();

a = [123;123;1234;12345;123456789];

data = table(a);

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

group = py.dash_table.Format.Group;

columns = {4};
columns{1} = struct('id', 'a', 'name', 'No groups',...
    'type','numeric','format',py.dash_table.Format.Format());
columns{2} = struct('id', 'a', 'name', 'Groups of 3',...
    'type','numeric','format',py.dash_table.Format.Format().group(true));
columns{3} = struct('id', 'a', 'name', 'Groups of 4',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('group', true, 'groups', py.list({py.int(4)}))));
columns{4} = struct('id', 'a', 'name', 'Groups of 2,3,2',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('group', group.yes)).groups(py.list({py.int(2),py.int(3),py.int(4)})));
columns = {columns};

uit.UserData = struct(...
    'columns', columns);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))