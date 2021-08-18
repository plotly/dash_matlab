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
uit3 = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

scheme = py.dash_table.Format.Scheme;
trim = py.dash_table.Format.Trim;

customColumns_1 = {8};
customColumns_1{1} = py.dict(pyargs('id', 'a', 'name', 'No precision',...
    'type','numeric','format',py.dash_table.Format.Format()));
customColumns_1{2} = py.dict(pyargs('id', 'a', 'name', 'Default',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2)))));
customColumns_1{3} = py.dict(pyargs('id', 'a', 'name', 'Fixed',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.fixed))));
customColumns_1{4} = py.dict(pyargs('id', 'a', 'name', 'Decimal',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.decimal))));
customColumns_1{5} = py.dict(pyargs('id', 'a', 'name', 'Integer',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.decimal_integer))));
customColumns_1{6} = py.dict(pyargs('id', 'a', 'name', 'Decimal/Exponent',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.decimal_or_exponent))));
customColumns_1{7} = py.dict(pyargs('id', 'a', 'name', 'Decimal SI',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.decimal_si_prefix))));
customColumns_1{8} = py.dict(pyargs('id', 'a', 'name', 'Exponent',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.exponent))));
customColumns_1 = py.list(customColumns_1);


customColumns_2 = {7};
customColumns_2{1} = py.dict(pyargs('id', 'a', 'name', 'Percentage',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.percentage))));
customColumns_2{2} = py.dict(pyargs('id', 'a', 'name', 'Rounded Percentage',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.percentage_rounded))));
customColumns_2{3} = py.dict(pyargs('id', 'a', 'name', 'Binary',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.binary))));
customColumns_2{4} = py.dict(pyargs('id', 'a', 'name', 'Octal',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.octal))));
customColumns_2{5} = py.dict(pyargs('id', 'a', 'name', 'hex',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.lower_case_hex))));
customColumns_2{6} = py.dict(pyargs('id', 'a', 'name', 'HEX',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.upper_case_hex))));
customColumns_2{7} = py.dict(pyargs('id', 'a', 'name', 'Unicode',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(2),'scheme',scheme.unicode))));
customColumns_2 = py.list(customColumns_2);


customColumns_3 = {3};
customColumns_3{1} = py.dict(pyargs('id', 'a', 'name', '4 decimals',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(4),'scheme',scheme.fixed))));
customColumns_3{2} = py.dict(pyargs('id', 'a', 'name', '4 decimals / trimmed',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',py.int(4),'scheme',scheme.fixed,'trim',trim.yes))));
customColumns_3{3} = py.dict(pyargs('id', 'a', 'name', 'Custom 4 decimals / trimmed',...
    'type','numeric','format',py.dict(pyargs('specifier','.4~f'))));
customColumns_3 = py.list(customColumns_3);

uit1.UserData = struct(...
    'customColumns', customColumns_1);
uit2.UserData = struct(...
    'customColumns', customColumns_2);
uit3.UserData = struct(...
    'customColumns', customColumns_3);

dash_table1 = ui2dash(uit1, 'table1');
dash_table2 = ui2dash(uit2, 'table2');
dash_table3 = ui2dash(uit3, 'table3');

br = py.dash_html_components.Br;

% add table to Dash app layout
table_app.layout = addLayout(dash_table1, br, dash_table2, br, dash_table3);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))