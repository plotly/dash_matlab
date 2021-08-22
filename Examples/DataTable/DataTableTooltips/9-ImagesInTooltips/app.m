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

% Tooltips
tooltip_data = {3};
tooltip_data{1} = struct('shop', struct(...
    'value', sprintf('Location at Bakersfield\n\n![Bakersfield](%s)', string(table_app.get_relative_path('/assets/images/table/bakersfield.jpg'))),...
    'type', 'markdown'));
tooltip_data{2} = struct('shop', struct(...
    'value', sprintf('Location at Berkeley\n\n![Berkeley](%s)', string(table_app.get_relative_path('/assets/images/table/berkeley.jpg'))),...
    'type', 'markdown'));
tooltip_data{3} = struct('shop', struct(...
    'value', 'Location at Big Bear Lake\n\n![Big Bear Lake](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Big_Bear_Valley%2C_California.jpg/1200px-Big_Bear_Valley%2C_California.jpg)',...
    'type', 'markdown'));
tooltip_data = py.list(tooltip_data);

style_data_conditional = {1};
style_data_conditional{1} = struct(...
        'if', struct('column_id', 'shop'),...
        'textDecoration', 'underline',...
        'textDecorationStyle', 'dotted');
style_data_conditional = py.list(style_data_conditional);

% User data
uit.UserData = struct(...
    'customColumns', customColumns,...
    'tooltip_data', tooltip_data,...
    'style_data_conditional', style_data_conditional,...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))