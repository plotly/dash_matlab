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

columns_1 = {8};
columns_1{1} = struct('id', 'a', 'name', 'No precision',...
    'type','numeric','format',py.dash_table.Format.Format());
columns_1{2} = struct('id', 'a', 'name', 'Default',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('precision',uint16(2))));
columns_1{3} = struct('id', 'a', 'name', 'Fixed',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.fixed)));
columns_1{4} = struct('id', 'a', 'name', 'Decimal',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.decimal)));
columns_1{5} = struct('id', 'a', 'name', 'Integer',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.decimal_integer)));
columns_1{6} = struct('id', 'a', 'name', 'Decimal/Exponent',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.decimal_or_exponent)));
columns_1{7} = struct('id', 'a', 'name', 'Decimal SI',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.decimal_si_prefix)));
columns_1{8} = struct('id', 'a', 'name', 'Exponent',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.exponent)));
columns_1 = {columns_1};


columns_2 = {7};
columns_2{1} = struct('id', 'a', 'name', 'Percentage',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.percentage)));
columns_2{2} = struct('id', 'a', 'name', 'Rounded Percentage',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.percentage_rounded)));
columns_2{3} = struct('id', 'a', 'name', 'Binary',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.binary)));
columns_2{4} = struct('id', 'a', 'name', 'Octal',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.octal)));
columns_2{5} = struct('id', 'a', 'name', 'hex',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.lower_case_hex)));
columns_2{6} = struct('id', 'a', 'name', 'HEX',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.upper_case_hex)));
columns_2{7} = struct('id', 'a', 'name', 'Unicode',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(2),'scheme',scheme.unicode)));
columns_2 = {columns_2};


columns_3 = {3};
columns_3{1} = struct('id', 'a', 'name', '4 decimals',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(4),'scheme',scheme.fixed)));
columns_3{2} = struct('id', 'a', 'name', '4 decimals / trimmed',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('precision',uint16(4),'scheme',scheme.fixed,'trim',trim.yes)));
columns_3{3} = struct('id', 'a', 'name', 'Custom 4 decimals / trimmed',...
    'type','numeric',...
    'format',py.dict(pyargs('specifier','.4~f')));
columns_3 = {columns_3};

uit1.UserData = struct(...
    'columns', columns_1);
uit2.UserData = struct(...
    'columns', columns_2);
uit3.UserData = struct(...
    'columns', columns_3);

dash_table1 = ui2dash(uit1, 'table1');
dash_table2 = ui2dash(uit2, 'table2');
dash_table3 = ui2dash(uit3, 'table3');

br = py.dash_html_components.Br;

% add table to Dash app layout
table_app.layout = addLayout(dash_table1, br, dash_table2, br, dash_table3);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))