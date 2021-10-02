terminate(pyenv);
clearvars;

% Define data table
Date = {'2015-01-01';'2015-10-24';'2016-05-10';'2017-01-10';'2018-05-10';'2018-08-15'};
Delivery = {'2015-01-02';'2015-10-24';'2016-05-15';'2017-01-14';'2018-05-10';'2018-08-11'};
Region = {'Montreal';'Toronto';'New York City';'Miami';'San Francisco';'London'};
Temperature = [1;-20;3.512;4;10423;-441.2];
Humidity = [10;20;30;40;50;60];
Pressure = [2;10924;3912;-10;3591.2;15];

data = table(Date, Delivery, Region, Temperature, Humidity, Pressure);

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

lncols = width(data);

style_data_conditional = {lncols};

for i=1:lncols
    col = string(data.Properties.VariableNames(i));
    style_data_conditional{i} = struct(...
        'if', struct('filter_query', sprintf('{%s} >= -10 && {%s} < 45', col, col),...
            'column_id', col),...
        'backgroundColor', '#B10DC9',...
        'color', 'white');
end
style_data_conditional = {style_data_conditional};

dataTable.UserData = struct(...
    'sort_action', 'native',...
    'style_data_conditional', style_data_conditional);

% Run the app
startDash(uiGrid, 8057);