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

data.Rating = strings(height(data),1);
for i=1:height(data)
    if data.Humidity(i) > 30
        data.Rating(i) = '⭐⭐⭐';
    elseif  data.Humidity(i) > 20
        data.Rating(i) = '⭐⭐';
    elseif  data.Humidity(i) > 10
        data.Rating(i) = '⭐';
    else
        data.Rating(i) = '';
    end
end

data.Growth = strings(height(data),1);
for i=1:height(data)
    if data.Temperature(i) > 0
        data.Growth(i) = '↗️';
    else
        data.Growth(i) = '↘️';
    end
end

data.Status = strings(height(data),1);
for i=1:height(data)
    if data.Temperature(i) > 0
        data.Status(i) = '🔥';
    else
        data.Status(i) = '🚒';
    end
end

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

dataTable.UserData = struct();

% Run the app
startDash(uiGrid, 8057);