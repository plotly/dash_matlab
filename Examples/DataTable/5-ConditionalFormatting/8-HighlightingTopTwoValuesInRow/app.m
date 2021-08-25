clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm2.csv', 'PreserveVariableNames', true);

data.id = (0:height(data)-1).'; % Add index column, starting from 0

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

[lnrows, lncols] = size(data);

[maxRows, maxIn] = max(data{1:end,2:end-1},[],2);

nlargest = 2;
style_data_conditional = {lnrows*nlargest};
cnt = 0;
for i=1:lnrows
    row = [];
    for k=1:lncols
        if isnumeric(data{i,k}) && (string(data.Properties.VariableNames(k))~='id')
            row(end+1) = data{i,k};
        end
    end
    
    [row, I] = sort(row, 'descend');
    for j=1:nlargest
        cnt = cnt+1;
        style_data_conditional{cnt}  = struct(...
            'if', struct('filter_query', sprintf('{id} = %d', i-1),...
            'column_id', string(data.Properties.VariableNames(I(j)+1))),...
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

uit.UserData = struct(...
    'sort_action', 'native',...
    'columns', columns,...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))