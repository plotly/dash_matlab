clear all
close all
terminate(pyenv);

% Define data table
shop = {'Bakersfield';'Berkeley';'Big Bear Lake'};
sales = [4;10;5];
goal = [10;1;4];
data = table(shop,sales,goal);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

% Define custom columns
[~, lncols] = size(uit.Data);
customColumns = {lncols};
customColumns{1} = py.dict(pyargs('name', 'Store Location', 'id', 'shop'));
customColumns{2} = py.dict(pyargs('name', 'Sales Revenue', 'id', 'sales'));
customColumns{3} = py.dict(pyargs('name', 'Revenue Goal', 'id', 'goal'));
customColumns = py.list(customColumns);

markdown_table = sprintf(...
    "| City       | Value     | Return     |\n"+...
    "| :------------- | :----------: | -----------: |\n"+...
    "|  Montreal   | 41,531    | 431.245 |\n"+...
    "| Seattle   | 53,153 | 12.431 |"...
);

[~, lncols] = size(uit.Data);

% Tooltips
tooltip = {3};
for i=1:lncols
    c = string(data.Properties.VariableNames(i));
    tooltip{i} = struct(c, struct('value',markdown_table,'type','markdown'));
end

% User data
uit.UserData = struct(...
    'customColumns', customColumns,...
    'tooltip', tooltip,...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))