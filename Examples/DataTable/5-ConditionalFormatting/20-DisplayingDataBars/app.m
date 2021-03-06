terminate(pyenv);
clearvars;

% Define data table
data = readtable('https://git.io/JgTYg', 'PreserveVariableNames', true);
data = data((1:100),:); % Select first 100 rows

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

n_bins = 100;
bounds = {n_bins+1};
for i=1:n_bins+1
    bounds{i} = (i-1)*(1.0/n_bins);
end
columns = ["lifeExp", "gdpPercap"];

styles = {};
for j=1:length(columns)
    col = columns(j);
    maxC = max(data{:,col});
    minC = min(data{:,col});

    ranges = {length(bounds)};
    for i=1:length(bounds)
        ranges{i} = ((maxC-minC)*bounds{i})+minC;
    end

    for i=2:length(bounds)
        min_bound = ranges{i-1};
        max_bound = ranges{i};
        max_bound_percentage = bounds{i}*100;

        if i < length(bounds)-2
            cond = sprintf('{%s} >= %d && {%s} < %d', col, min_bound, col, max_bound);
        else
            cond = sprintf('{%s} >= %d', col, min_bound);
        end
        styles{end+1} = struct(...
            'if', struct('filter_query', cond,...
            'column_id', sprintf('%s', col)),...
            'background', sprintf(""+...
                            "linear-gradient(90deg,"+...
                            "#0074D9 0%%,"+...
                            "#0074D9 %d%%,"+...
                            "white %d%%,"+...
                            "white 100%%"+...
                                "", max_bound_percentage,max_bound_percentage),...
            'paddingBottom', 2,...
            'paddingTop', 2);
    end  
end

style_data_conditional = {styles};

dataTable.UserData = struct(...
    'sort_action', 'native',...
    'style_data_conditional', style_data_conditional,...
    'style_cell', struct(...
        'width','100px',...
        'minWidth','100px',...
        'maxWidth','100px',...
        'overflow','hidden',...
        'textOverflow','ellipsis'),...
    'page_size', 10);

% Run the app
startDash(uiGrid, 8057);