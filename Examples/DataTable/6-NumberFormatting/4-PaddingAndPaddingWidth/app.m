clear all
close all
terminate(pyenv);

a = [123;123;1234;12345;123456789];

data = table(a);

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

padding = py.dash_table.Format.Padding;

columns = {4};
columns{1} = struct('id', 'a', 'name', 'No padding',...
    'type','numeric','format',py.dash_table.Format.Format());
columns{2} = struct('id', 'a', 'name', 'Padding 12',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('padding',true,'padding_width',uint16(12))));
columns{3} = struct('id', 'a', 'name', 'Padding 9',...
    'type','numeric',...
    'format',py.dash_table.Format.Format(pyargs('padding',padding.yes)).padding_width(uint16(9)));
columns{4} = struct('id', 'a', 'name', 'Padding 6',...
    'type','numeric',...
    'format',struct('specifier','06'));
columns = {columns};

uit.UserData = struct(...
    'columns', columns);

dashTable = ui2dash(uit, 'table');

% add table to Dash app layout
components = {dashTable};

% run the app
startDash(components, 8057, [], 'SOLAR');