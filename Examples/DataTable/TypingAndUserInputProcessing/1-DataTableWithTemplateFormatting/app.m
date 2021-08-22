clear all
close all
terminate(pyenv);

% Define data table
city = {'Vancouver'; 'Toronto'; 'Calgary'; 'Ottawa'; 'Montreal'; 'Halifax'; 'Regina'; 'Fredericton'};
average_04_2018 = [1092000; 766000; 431000; 382000; 341000; 316000; 276000; 173000];
change_04_2017_04_2018 = [0.143; -0.051; 0.001; 0.083; 0.063; 0.024; -0.065; 0.012];
data = table(city,average_04_2018,change_04_2017_04_2018);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

sign = py.dash_table.Format.Sign;
a = py.dash_table.FormatTemplate.percentage(py.int(1)).sign(sign.positive);
%a.sign
%asd
% Define custom columns
[~, lncols] = size(uit.Data);
customColumns = {lncols};
customColumns{1} = struct('id','city','name','City','type','text');
customColumns{2} = struct('id','average_04_2018','name','Average Price ($)',...
    'type','numeric', 'format', py.dash_table.FormatTemplate.money(py.int(0)));
customColumns{3} = struct('id','change_04_2017_04_2018','name','Variation (%)',...
    'type','numeric', 'format', a);
customColumns = py.list(customColumns);

% User data
uit.UserData = struct(...
    'customColumns', customColumns,...
    'editable', true);

dash_table = ui2dash(uit, 'typing_formatting_1');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))