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

customColumns = {4};
customColumns{1} = py.dict(pyargs('id', 'a', 'name', 'No groups',...
    'type','numeric','format',py.dash_table.Format.Format()));
customColumns{2} = py.dict(pyargs('id', 'a', 'name', 'Groups of 3',...
    'type','numeric','format',py.dash_table.Format.Format().group(true)));
customColumns{3} = py.dict(pyargs('id', 'a', 'name', 'Groups of 4',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('group', true, 'groups', py.list({py.int(4)})))));
customColumns{4} = py.dict(pyargs('id', 'a', 'name', 'Groups of 2,3,2',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('group', group.yes)).groups(py.list({py.int(2),py.int(3),py.int(4)}))));
customColumns = py.list(customColumns);

uit.UserData = struct(...
    'customColumns', customColumns);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))