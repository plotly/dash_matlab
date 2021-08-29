clear all
close all
terminate(pyenv);

% Define data table
year = [0:1:9]';
montreal = [0:10:90]';
toronto = [0:100:900]';
ottawa = [0:-1:-9]';
vancouver = [0:-10:-90]';
temp = [0:-100:-900]';
humidity = [0:5:45]';
data = table(year,montreal,toronto,ottawa,vancouver,temp,humidity);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

% Define custom columns
[~, lncols] = size(uit.Data);
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
uit.UserData = struct(...
    'columns', columns,...
    'merge_duplicate_headers', true,...
    'tooltip_header', tooltip_header,...
    'style_header', struct(...
        'textDecoration', 'underline',...
        'textDecorationStyle', 'dotted'));

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))