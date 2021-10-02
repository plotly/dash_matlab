terminate(pyenv);
clearvars;

tableApp = createApp();

% Define data table
shop = {'Bakersfield';'Berkeley';'Big Bear Lake'};
sales = [4;10;5];
goal = [10;1;4];
data = table(shop,sales,goal);

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

% Define custom columns
lncols = width(dataTable.Data);
columns = {lncols};
columns{1} = struct('name', 'Store Location', 'id', 'shop');
columns{2} = struct('name', 'Sales Revenue', 'id', 'sales');
columns{3} = struct('name', 'Revenue Goal', 'id', 'goal');
columns = {columns};

% Tooltips
tooltip_data = {3};
tooltip_data{1} = struct('shop', struct(...
    'value', sprintf('Location at Bakersfield\n\n![Bakersfield](%s)', string(tableApp.get_relative_path('/assets/images/table/bakersfield.jpg'))),...
    'type', 'markdown'));
tooltip_data{2} = struct('shop', struct(...
    'value', sprintf('Location at Berkeley\n\n![Berkeley](%s)', string(tableApp.get_relative_path('/assets/images/table/berkeley.jpg'))),...
    'type', 'markdown'));
tooltip_data{3} = struct('shop', struct(...
    'value', 'Location at Big Bear Lake\n\n![Big Bear Lake](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Big_Bear_Valley%2C_California.jpg/1200px-Big_Bear_Valley%2C_California.jpg)',...
    'type', 'markdown'));
tooltip_data = {tooltip_data};

style_data_conditional = {1};
style_data_conditional{1} = struct(...
        'if', struct('column_id', 'shop'),...
        'textDecoration', 'underline',...
        'textDecorationStyle', 'dotted');
style_data_conditional = {style_data_conditional};

% User data
dataTable.UserData = struct(...
    'columns', columns,...
    'tooltip_data', tooltip_data,...
    'style_data_conditional', style_data_conditional,...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

% Run the app
startDash(uiGrid, 8057);