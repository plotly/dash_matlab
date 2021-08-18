clear all
close all
terminate(pyenv);

% create Dash app
table_app = createApp();

a = [123;123;1234;12345;123456789];

data = table(a);

% create ui elements
uifig = uifigure('visible', 'off');
uit1 = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');
uit2 = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');
uit3 = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

group = py.dash_table.Format.Group;
prefix = py.dash_table.Format.Prefix;
scheme = py.dash_table.Format.Scheme;
symbol = py.dash_table.Format.Symbol;

customColumns_1 = {4};
customColumns_1{1} = py.dict(pyargs('id', 'a', 'name', 'Symbol',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.yes))));
customColumns_1{2} = py.dict(pyargs('id', 'a', 'name', 'Symbol prefix',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.yes,'symbol_prefix','CAD$ '))));
customColumns_1{3} = py.dict(pyargs('id', 'a', 'name', 'Symbol suffix',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('symbol',symbol.yes,'symbol_suffix',' CAD$'))));
customColumns_1{4} = py.dict(pyargs('id', 'a', 'name', 'Symbol custom',...
    'type','numeric','format',py.dict(pyargs('specifier','$','locale',py.dict(pyargs('symbol',py.list({'@','*'})))))));
customColumns_1 = py.list(customColumns_1);


customColumns_2 = {4};
customColumns_2{1} = py.dict(pyargs('id', 'a', 'name', 'Decimal',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('decimal_delimiter',':')).scheme('f').precision(py.int(2))));
customColumns_2{2} = py.dict(pyargs('id', 'a', 'name', 'Custom decimal',...
    'type','numeric','format',py.dict(pyargs('specifier','.2f','locale',py.dict(pyargs('decimal',':'))))));
customColumns_2{3} = py.dict(pyargs('id', 'a', 'name', 'Group',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('group_delimiter',':','group',group.yes,'groups',py.list({py.int(2)})))));
customColumns_2{4} = py.dict(pyargs('id', 'a', 'name', 'Custom group',...
    'type','numeric','format',py.dict(pyargs('specifier',',','locale',py.dict(pyargs('group',':','grouping',py.list({py.int(2)})))))));
customColumns_2 = py.list(customColumns_2);


customColumns_3 = {6};
customColumns_3{1} = py.dict(pyargs('id', 'a', 'name', 'Custom numerals',...
    'type','numeric','format',py.dict(pyargs('locale',py.dict(pyargs('numerals',...
        py.list({'0','AA','b','CC','','','','77','88','99'})))))));
customColumns_3{2} = py.dict(pyargs('id', 'a', 'name', 'Percent symbol',...
    'type','numeric','format',py.dict(pyargs('specifier','.2%','locale',py.dict(pyargs('percent','@'))))));
customColumns_3{3} = py.dict(pyargs('id', 'a', 'name', 'Group 4 digits',...
    'type','numeric','format',py.dict(pyargs('specifier',',.0f','locale',py.dict(pyargs('separate_4digits',false))))));
customColumns_3{4} = py.dict(pyargs('id', 'a', 'name', 'SI',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('si_prefix',prefix.milli)).precision(py.int(0))));
customColumns_3{5} = py.dict(pyargs('id', 'a', 'name', 'SI+space',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('si_prefix',prefix.milli,'symbol',symbol.yes,'symbol_suffix',' ')).precision(py.int(0))));
customColumns_3{6} = py.dict(pyargs('id', 'a', 'name', 'Explicit SI',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('si_prefix',10^-3)).precision(py.int(0))));
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