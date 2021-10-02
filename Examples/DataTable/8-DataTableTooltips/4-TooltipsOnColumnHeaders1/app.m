terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr');

data = data((1:3),:); % Select first 3 rows

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

lncols = width(dataTable.Data);

tooltip_header = struct();
for i=1:lncols
    fld = string(dataTable.ColumnName(i));
    tooltip_header.(fld) = fld;
end

dataTable.UserData = struct(...
    'tooltip_header', tooltip_header,...
    'style_header', struct(...
        'textDecoration','underline',...
        'textDecorationStyle','dotted'),...
    'style_cell', struct(...
        'overflow','hidden',...
        'textOverflow','ellipsis',...
        'maxWidth',0),...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

% Run the app
startDash(uiGrid, 8057);