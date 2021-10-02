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

data.id = (0:height(data)-1).'; % Add index column, starting from 0

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

lncols = width(dataTable.Data);
lnrows = height(dataTable.Data);

[maxVals,maxLocs] = max(data{:,4:end},[],2);
maxVal = max(maxVals);
lia = ismember(maxVals, maxVal);
idx = find(lia);

style_data_conditional = {length(idx)};
cnt = 0;
for i=1:lnrows
    if maxVals(i) == maxVal
        cnt = cnt+1;
        col = string(data.Properties.VariableNames(maxLocs(i)+3));
        style_data_conditional{cnt}  = struct(...
            'if', struct('filter_query', sprintf('{%s} = %d', col, maxVal),...
            'column_id', col),...
            'backgroundColor', '#39CCCC',...
            'color', 'white');
    end
end
style_data_conditional = {style_data_conditional};

columns = {lncols-1};
for i=1:lncols-1
    columns{i} = struct('name', string(data.Properties.VariableNames(i)),...
        'id', string(data.Properties.VariableNames(i)));
end
columns = {columns};

dataTable.UserData = struct(...
    'sort_action', 'native',...
    'columns', columns,...
    'style_data_conditional', style_data_conditional);

% Run the app
startDash(uiGrid, 8057);