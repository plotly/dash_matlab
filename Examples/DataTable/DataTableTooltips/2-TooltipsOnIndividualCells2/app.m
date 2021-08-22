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
[lnrows, lncols] = size(uit.Data);
customColumns = {lncols};
customColumns{1} = py.dict(pyargs('name', 'Store Location', 'id', 'shop'));
customColumns{2} = py.dict(pyargs('name', 'Sales Revenue', 'id', 'sales'));
customColumns{3} = py.dict(pyargs('name', 'Revenue Goal', 'id', 'goal'));
customColumns = py.list(customColumns);

% Tooltips
tooltip_data = {3};
tooltip_data{1} = py.dict(pyargs(...
    'shop', 'Location at Bakersfield',...
    'sales', '$4M in Revenue',...
    'goal', py.dict(pyargs('value','6M **under** Goal','type','markdown'))));
tooltip_data{2} = py.dict(pyargs(...
    'shop', 'Location at Berkley',...
    'sales', '$10M in Revenue',...
    'goal', py.dict(pyargs('value','9M **over** Goal','type','markdown'))));
tooltip_data{3} = py.dict(pyargs(...
    'shop', 'Location at Big Bear Lake',...
    'sales', '$5M in Revenue',...
    'goal', py.dict(pyargs('value','1M **over** Goal','type','markdown'))));
tooltip_data = py.list(tooltip_data);

% User data
uit.UserData = struct(...
    'customColumns', customColumns,...
    'tooltip_data', tooltip_data,...
    'style_cell', struct(...
        'overflow', 'hidden',...
        'textOverflow', 'ellipsis',...
        'maxWidth', 0),...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))