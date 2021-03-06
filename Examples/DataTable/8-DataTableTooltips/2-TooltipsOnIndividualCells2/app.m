terminate(pyenv);
clearvars;

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
lnrows = height(dataTable.Data);

columns = {lncols};
columns{1} = struct('name', 'Store Location', 'id', 'shop');
columns{2} = struct('name', 'Sales Revenue', 'id', 'sales');
columns{3} = struct('name', 'Revenue Goal', 'id', 'goal');
columns = {columns};

% Tooltips
tooltip_data = {3};
tooltip_data{1} = struct(...
    'shop', 'Location at Bakersfield',...
    'sales', '$4M in Revenue',...
    'goal', struct('value','6M **under** Goal','type','markdown'));
tooltip_data{2} = struct(...
    'shop', 'Location at Berkley',...
    'sales', '$10M in Revenue',...
    'goal', struct('value','9M **over** Goal','type','markdown'));
tooltip_data{3} = struct(...
    'shop', 'Location at Big Bear Lake',...
    'sales', '$5M in Revenue',...
    'goal', struct('value','1M **over** Goal','type','markdown'));
tooltip_data = {tooltip_data};

% User data
dataTable.UserData = struct(...
    'columns', columns,...
    'tooltip_data', tooltip_data,...
    'style_cell', struct(...
        'overflow', 'hidden',...
        'textOverflow', 'ellipsis',...
        'maxWidth', 0),...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

% Run the app
startDash(uiGrid, 8057);