terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', false);
data = data((1:3),:); % Select first 3 rows

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

[lnrows, lncols] = deal(height(dataTable.Data), width(dataTable.Data));
tooltip_data = {lnrows};
for i=1:lnrows
    d = struct();
    for j=1:lncols
        fld = string(dataTable.ColumnName(j));
        d.(fld) = struct(...
            'value', string(dataTable.Data{i,j}), 'type', 'markdown');
    end
    tooltip_data{i} = d;
end

tooltip_data = {tooltip_data};

dataTable.UserData = struct(...
    'style_cell', struct(...
        'overflow', 'hidden',...
        'textOverflow', 'ellipsis',...
        'maxWidth', 0),...
    'tooltip_data', tooltip_data,...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

% Run the app
startDash(uiGrid, 8057);