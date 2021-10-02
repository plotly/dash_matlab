terminate(pyenv);
clearvars;

% Define data table
Firm = {'Acme';'Olive';'Barnwood';'Henrietta'};
y2017 = {"";'None';'NaN';14};
y2018 = [5;3;7;1];
y2019 = [10;13;3;13];
y2020 = [4;3;6;1];

data = table(Firm, y2017, y2018, y2019, y2020);

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
        'if', struct('filter_query', sprintf('{%s} = %d', col, 3),...
            'column_id', col),...
        'backgroundColor', 'tomato',...
        'color', 'white'); 
end
style_data_conditional{2}.if

style_data_conditional = {style_data_conditional};


dataTable.UserData = struct(...
    'style_data_conditional', style_data_conditional);

% Run the app
startDash(uiGrid, 8057);