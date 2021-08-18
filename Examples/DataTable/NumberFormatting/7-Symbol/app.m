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

customColumns_1 = {5};
customColumns_1{1} = py.dict(pyargs('id', 'a', 'name', 'Default',...
    'type','numeric','format',py.dash_table.Format.Format()));
customColumns_1{2} = py.dict(pyargs('id', 'a', 'name', 'No Symbol',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.no))));
customColumns_1{3} = py.dict(pyargs('id', 'a', 'name', '$ Symbol',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.yes))));
customColumns_1{4} = py.dict(pyargs('id', 'a', 'name', '$ Symbol / Locale prefix',...
    'type','numeric','format',py.dash_table.Format.Format().symbol(symbol.yes).symbol_prefix('@')));
customColumns_1{5} = py.dict(pyargs('id', 'a', 'name', '$ Symbol / Locale prefix+suffix',...
    'type','numeric','format',py.dash_table.Format.Format().symbol(symbol.yes).symbol_prefix('@').symbol_suffix('*')));
customColumns_1 = py.list(customColumns_1);


customColumns_2 = {4};
customColumns_2{1} = py.dict(pyargs('id', 'a', 'name', 'Binary',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.binary))));
customColumns_2{2} = py.dict(pyargs('id', 'a', 'name', 'Octal',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.octal))));
customColumns_2{3} = py.dict(pyargs('id', 'a', 'name', 'Hex',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.hex))));
customColumns_2{4} = py.dict(pyargs('id', 'a', 'name', 'Custom',...
    'type','numeric','format',py.dict(pyargs('locale',py.dict(pyargs('symbol',py.list({'@','*'}))),'specifier','$'))));
customColumns_2 = py.list(customColumns_2);


uit1.UserData = struct(...
    'customColumns', customColumns_1);
uit2.UserData = struct(...
    'customColumns', customColumns_2);

dash_table1 = ui2dash(uit1, 'table1');
dash_table2 = ui2dash(uit2, 'table2');

br = py.dash_html_components.Br;

% add table to Dash app layout
table_app.layout = addLayout(dash_table1, br, dash_table2);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))