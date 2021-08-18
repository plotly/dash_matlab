clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm2.csv', 'PreserveVariableNames', true);
try
    data = data([1:20],[1:7]); % Select first 20 rows and first 7 columns
catch
end

data.id = (0:height(data)-1).'; % Add index column, starting from 0

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

[lnrows, lncols] = size(data);

[maxVals,maxLocs] = max(data{:,2:end-1},[],2);
maxVal = max(maxVals);
lia = ismember(maxVals, maxVal);
idx = find(lia);

style_data_conditional = {length(idx)};
cnt = 0;
for i=1:lnrows
    if maxVals(i) == maxVal
        cnt = cnt+1;
        col = string(data.Properties.VariableNames(maxLocs(i)+1));
        style_data_conditional{cnt}  = struct(...
            'if', struct('filter_query', sprintf('{%s} = %d', col, maxVal),...
            'column_id', col),...
            'backgroundColor', '#39CCCC',...
            'color', 'white');
    end
end
style_data_conditional = py.list(style_data_conditional);

customColumns = {lncols-1};
for i=1:lncols-1
    customColumns{i} = py.dict(pyargs('name', string(data.Properties.VariableNames(i)), 'id', string(data.Properties.VariableNames(i))));
end
customColumns = py.list(customColumns);

uit.UserData = struct(...
    'sort_action', 'native',...
    'customColumns', customColumns,...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))