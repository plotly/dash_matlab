clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm1.csv', 'PreserveVariableNames', true);
try
    data = data([1:20],[1:7]); % Select first 20 rows and first 7 columns
catch
end

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

%% Define struct which stores uitable properties like styling
% An example with cell and header stylings,
% as well as page_size property is provided:
%{
uit.UserData = struct(...
    'style_cell', struct(...
        'page_size', 3,...
        'textAlign', 'center',...
        'backgroundColor', 'rgb(50,50,50)',...
        'color', 'white',...
        'font_size', '16px',...
        'padding', '5px'),...
    'style_header', struct(...
        'backgroundColor', 'rgb(30,30,30)',...
        'fontWeight', 'bold'),...
    'page_size', 10);
%}
%%

uit.UserData = struct();

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))