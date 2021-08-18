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

padding = py.dash_table.Format.Padding;

customColumns = {4};
customColumns{1} = py.dict(pyargs('id', 'a', 'name', 'No padding',...
    'type','numeric','format',py.dash_table.Format.Format()));
customColumns{2} = py.dict(pyargs('id', 'a', 'name', 'Padding 12',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('padding',true,'padding_width',py.int(12)))));
customColumns{3} = py.dict(pyargs('id', 'a', 'name', 'Padding 9',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('padding',padding.yes)).padding_width(py.int(9))));
customColumns{4} = py.dict(pyargs('id', 'a', 'name', 'Padding 6',...
    'type','numeric','format',py.dict(pyargs('specifier','06'))));
customColumns = py.list(customColumns);

uit.UserData = struct(...
    'customColumns', customColumns);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))