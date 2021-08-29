clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm1.csv', 'PreserveVariableNames', true);

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

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

uit.UserData = struct();

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))