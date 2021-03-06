terminate(pyenv);
clearvars;

uiFigure = uifigure('visible', 'off');

% Dropdown (bar, scatter, line, etc)
dropdown = uidropdown(uiFigure,...
    'Items', {'Line'; 'Scatter'; 'Bar'},...
    'Value', 'Scatter');
uiDropdown = ui2dash(dropdown, 'my-dropdown');
myDropdownDiv = Html('Div', {uiDropdown, 'style', struct(...
    'width', '25%', 'padding', 10)});

% Data
data = table;

a = 50;
b = 100;
N = 20;
data.x = (1:1:N)';
data.y = round((b-a).*rand(N,1) + a, 2);

% DataTable
dataTable = uitable(uiFigure, 'ColumnName', data.Properties.VariableNames,...
    'Data', data);

% Define struct which stores uitable properties like styling
dataTable.UserData = struct(...
    'editable', true,...
    'style_data', struct(...
        'width', '100px',...
        'maxWidth', '100px',...
        'minWidth', '100px',...
        'backgroundColor', 'rgb(50, 50, 50)',...
        'color', 'white'),...
    'style_cell_conditional', {{struct(...
        'if', struct('column_id', 'x'),...
        'textAlign', 'left')}},...
    'style_header', struct(...
        'fontWeight', 'bold',...
        'backgroundColor', 'rgb(30, 30, 30)'),...
    'fill_width', false,...
    'style_as_list_view', true);

myTable = ui2dash(dataTable, 'my-table');
myTableDiv = Html('Div', {myTable, 'style', struct(...
    'float', 'left', 'margin', 'auto', 'padding', 10)});

% Initial Plot
ax = axes('Tag', 'my-plot');
graph = ui2dash(ax);
myGraphDiv = Html('Div', {graph, 'style', struct(...
    'float', 'left', 'margin', 'auto', 'padding', 10)});

components = {myDropdownDiv, myTableDiv, myGraphDiv};

% Define the callbacks
args = {...
    argsOut('my-plot', 'figure'),...
    argsIn('my-table','data'),...
    argsIn('my-dropdown', 'value')};  
handle = 'updateGraph'; % Callback function

callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat, 'SOLAR');