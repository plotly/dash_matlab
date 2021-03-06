terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', false);
data = data((1:5),(1:6)); % Select first 5 rows and 6 columns

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

css = {1};
css{1} = struct(...
        'selector', '.dash-spreadsheet td div',...
        'rule', ""+...
            "line-height: 15px;"+...
            "max-height: 30px; min-height: 30px; height: 30px;"+...
            "display: block;"+...
            "overflow-y: hidden;"+...
                "");
css = {css};

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
    'style_data', struct(...
        'whiteSpace', 'normal'),...
    'style_cell', struct(...
        'textAlign', 'left'),...
    'css', css,...
    'tooltip_data', tooltip_data,...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

% Run the app
startDash(uiGrid, 8057);