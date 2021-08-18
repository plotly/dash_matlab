clear all
close all
terminate(pyenv);

% create Dash app
table_app = createApp();

a = [123.1;123.12;1234.123;12345.12;-123.1;-123.12;-1234.123;-12345.12];

data = table(a);

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

scheme = py.dash_table.Format.Scheme;
sign = py.dash_table.Format.Sign;

customColumns = {6};
customColumns{1} = py.dict(pyargs('id', 'a', 'name', 'Default',...
    'type','numeric','format',py.dash_table.Format.Format()));
customColumns{2} = py.dict(pyargs('id', 'a', 'name', 'Negative',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('sign',sign.negative))));
customColumns{3} = py.dict(pyargs('id', 'a', 'name', 'Positive',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('sign',sign.positive))));
customColumns{4} = py.dict(pyargs('id', 'a', 'name', 'Parentheses',...
    'type','numeric','format',py.dash_table.Format.Format().sign(sign.parantheses)));
customColumns{5} = py.dict(pyargs('id', 'a', 'name', 'Percentage/Parentheses',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('scheme',scheme.percentage,'precision',py.int(2),'sign',sign.parantheses))));
customColumns{6} = py.dict(pyargs('id', 'a', 'name', 'Custom',...
    'type','numeric','format',py.dict(pyargs('specifier','('))));

customColumns = py.list(customColumns);

uit.UserData = struct(...
    'customColumns', customColumns);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))