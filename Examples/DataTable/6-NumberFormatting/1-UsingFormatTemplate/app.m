clear all
close all
terminate(pyenv);

account = {'A';'B';'C'};
balance = [552.31;1607.9;-228.41];
rate = [0.139;0.1044;0.199];

data = table(account, balance, rate);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

money = py.dash_table.FormatTemplate.money(py.int(2));
percentage = py.dash_table.FormatTemplate.percentage(py.int(2));

[~, lncols] = size(uit.Data);
columns = {lncols};
columns{1} = struct('id', 'account', 'name', 'Account');
columns{2} = struct('id', 'balance', 'name', 'Balance',...
    'type','numeric','format',money);
columns{3} = struct('id', 'rate', 'name', 'Rate',...
    'type','numeric','format',percentage);

columns = {columns};

uit.UserData = struct(...
    'columns', columns);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))