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
[lnrows, lncols] = size(uit.Data);
customColumns = {lncols};
customColumns{1} = py.dict(pyargs('name', py.list({'','Year'}), 'id', 'year'));
customColumns{2} = py.dict(pyargs('name', py.list({'City','Montreal'}), 'id', 'montreal'));
customColumns{3} = py.dict(pyargs('name', py.list({'City','Toronto'}), 'id', 'toronto'));
customColumns{4} = py.dict(pyargs('name', py.list({'City','Ottawa'}), 'id', 'ottawa'));
customColumns{5} = py.dict(pyargs('name', py.list({'City','Vancouver'}), 'id', 'vancouver'));
customColumns{6} = py.dict(pyargs('name', py.list({'Climate','Temperature'}), 'id', 'temp'));
customColumns{7} = py.dict(pyargs('name', py.list({'Climate','Humidity'}), 'id', 'humidity'));
customColumns = py.list(customColumns);

% Tooltips
tooltip_header = py.dict(pyargs(...
    'year', py.list({'','Year the measurement was taken'}),...
    'montreal', py.list({'Average Measurements Across City', 'Montreal, QC, Canada'}),...
    'toronto', py.list({'Average Measurements Across City', 'Toronto, ON, Canada'}),...
    'ottawa', py.list({'Average Measurements Across City', 'Ottawa, ON, Canada'}),...
    'vancouver', py.list({'Average Measurements Across City', 'Vancouver, BC, Canada'}),...
    'temp', py.list({'Average for a Year', 'Celcius'}),...
    'humidity', py.list({'Average for a Year', 'Percentage'})));

% User data
uit.UserData = struct(...
    'customColumns', customColumns,...
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