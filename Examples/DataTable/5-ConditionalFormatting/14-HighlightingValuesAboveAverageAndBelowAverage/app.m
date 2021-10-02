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

style_data_conditional = {2*(lncols-3)};
count = 0;
for i=4:lncols
    col = string(data.Properties.VariableNames(i));
    x = data{:,col};
    
    value = quantile(x, 0.1);
    count = count+1;
    style_data_conditional{count} = struct(...
        'if', struct('filter_query', sprintf('{%s} > %d', col, value),...
            'column_id', col),...
        'backgroundColor', '#3D9970',...
        'color', 'white');
    
    value = quantile(x, 0.5);
    count = count+1;
    style_data_conditional{count} = struct(...
        'if', struct('filter_query', sprintf('{%s} <= %d', col, value),...
            'column_id', col),...
        'backgroundColor', '#FF4136',...
        'color', 'white');
end
style_data_conditional = {style_data_conditional};


dataTable.UserData = struct(...
    'sort_action', 'native',...
    'style_data_conditional', style_data_conditional);

% Run the app
startDash(uiGrid, 8057);