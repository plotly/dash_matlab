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

style_data_conditional = {1};
style_data_conditional{1} = struct(...
    'if', struct('filter_query', '{Date} datestartswith "2015-10"'),...
    'backgroundColor', '#85144b',...
    'color', 'white');
style_data_conditional = {style_data_conditional};

lncols = width(data);
columns = {lncols};
for i=1:lncols
    col = data.Properties.VariableNames{i};
    if ~strcmp(col, 'Date')
        columns{i} = struct('name', col, 'id', col);
    else
        columns{i} = struct('name', 'Date', 'id', 'Date', 'type', 'datetime');
    end
end
columns = {columns};

dataTable.UserData = struct(...
    'columns', columns,...
    'style_data_conditional', style_data_conditional);

% Run the app
startDash(uiGrid, 8057);