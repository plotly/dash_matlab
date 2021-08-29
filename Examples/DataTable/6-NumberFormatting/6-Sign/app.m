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

columns = {6};
columns{1} = struct('id', 'a', 'name', 'Default',...
    'type','numeric','format',py.dash_table.Format.Format());
columns{2} = struct('id', 'a', 'name', 'Negative',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('sign',sign.negative)));
columns{3} = struct('id', 'a', 'name', 'Positive',...
    'type','numeric','format',py.dash_table.Format.Format(pyargs('sign',sign.positive)));
columns{4} = struct('id', 'a', 'name', 'Parentheses',...
    'type','numeric','format',py.dash_table.Format.Format().sign(sign.parantheses));
columns{5} = struct('id', 'a', 'name', 'Percentage/Parentheses',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('scheme',scheme.percentage,'precision',uint16(2),'sign',sign.parantheses)));
columns{6} = struct('id', 'a', 'name', 'Custom',...
    'type','numeric','format',py.dict(pyargs('specifier','(')));

columns = {columns};

uit.UserData = struct(...
    'columns', columns);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))