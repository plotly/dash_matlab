clear all
close all
terminate(pyenv);

% create Dash app
table_app = createApp();

a = [123.1;123.12;1234.123;12345.12];

data = table(a);

% create ui elements
uifig = uifigure('visible', 'off');
uit1 = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');
uit2 = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

symbol = py.dash_table.Format.Symbol;

columns_1 = {5};
columns_1{1} = struct('id', 'a', 'name', 'Default',...
    'type','numeric','format',py.dash_table.Format.Format());
columns_1{2} = struct('id', 'a', 'name', 'No Symbol',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.no)));
columns_1{3} = struct('id', 'a', 'name', '$ Symbol',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.yes)));
columns_1{4} = struct('id', 'a', 'name', '$ Symbol / Locale prefix',...
    'type','numeric','format',py.dash_table.Format.Format().symbol(symbol.yes).symbol_prefix('@'));
columns_1{5} = struct('id', 'a', 'name', '$ Symbol / Locale prefix+suffix',...
    'type','numeric',...
    'format',py.dash_table.Format.Format().symbol(symbol.yes).symbol_prefix('@').symbol_suffix('*'));
columns_1 = {columns_1};


columns_2 = {4};
columns_2{1} = struct('id', 'a', 'name', 'Binary',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.binary)));
columns_2{2} = struct('id', 'a', 'name', 'Octal',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.octal)));
columns_2{3} = struct('id', 'a', 'name', 'Hex',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.hex)));
columns_2{4} = struct('id', 'a', 'name', 'Custom',...
    'type','numeric',...
    'format',py.dict(pyargs('locale',py.dict(pyargs('symbol',py.list({'@','*'}))),'specifier','$')));
columns_2 = {columns_2};


uit1.UserData = struct(...
    'columns', columns_1);
uit2.UserData = struct(...
    'columns', columns_2);

dash_table1 = ui2dash(uit1, 'table1');
dash_table2 = ui2dash(uit2, 'table2');

br = py.dash_html_components.Br;

% add table to Dash app layout
table_app.layout = addLayout(dash_table1, br, dash_table2);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))