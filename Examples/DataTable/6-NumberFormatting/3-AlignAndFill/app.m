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

align = py.dash_table.Format.Align;

columns = {4};
columns{1} = struct('id', 'a', 'name', 'No fill',...
    'type','numeric','format',py.dash_table.Format.Format());
columns{2} = struct('id', 'a', 'name', 'Align left (10)',...
    'type','numeric',...
    'format',py.dash_table.Format.Format().align(align.left).fill('-').padding_width(uint16(10)));
columns{3} = struct('id', 'a', 'name', 'Align right (8)',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('align', align.right, 'fill', '-', 'padding_width', py.int(8))));
columns{4} = struct('id', 'a', 'name', 'Align center (6)',...
    'type','numeric',...
    'format',struct('specifier','-^6'));
columns = {columns};

uit.UserData = struct(...
    'columns', columns);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))