terminate(pyenv);
clearvars;

% Define data table
year = [0:1:9]';
montreal = [0:10:90]';
toronto = [0:100:900]';
ottawa = [0:-1:-9]';
vancouver = [0:-10:-90]';
temp = [0:-100:-900]';
humidity = [0:5:45]';
data = table(year,montreal,toronto,ottawa,vancouver,temp,humidity);

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

% Define custom columns
lncols = width(dataTable.Data);

columns = {lncols};
columns{1} = struct('name', {{'','Year'}}, 'id', 'year');
columns{2} = struct('name', {{'City','Montreal'}}, 'id', 'montreal');
columns{3} = struct('name', {{'City','Toronto'}}, 'id', 'toronto');
columns{4} = struct('name', {{'City','Ottawa'}}, 'id', 'ottawa');
columns{5} = struct('name', {{'City','Vancouver'}}, 'id', 'vancouver');
columns{6} = struct('name', {{'Climate','Temperature'}}, 'id', 'temp');
columns{7} = struct('name', {{'Climate','Humidity'}}, 'id', 'humidity');
columns = {columns};

% Tooltips
tooltip_header = struct(...
    'year', {{'','Year the measurement was taken'}},...
    'montreal', {{'Average Measurements Across City', 'Montreal, QC, Canada'}},...
    'toronto', {{'Average Measurements Across City', 'Toronto, ON, Canada'}},...
    'ottawa', {{'Average Measurements Across City', 'Ottawa, ON, Canada'}},...
    'vancouver', {{'Average Measurements Across City', 'Vancouver, BC, Canada'}},...
    'temp', {{'Average for a Year', 'Celcius'}},...
    'humidity', {{'Average for a Year', 'Percentage'}});

% User data
dataTable.UserData = struct(...
    'columns', columns,...
    'merge_duplicate_headers', true,...
    'tooltip_header', tooltip_header,...
    'style_header', struct(...
        'textDecoration', 'underline',...
        'textDecorationStyle', 'dotted'));

% Run the app
startDash(uiGrid, 8057);