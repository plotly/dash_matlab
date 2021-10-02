terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Juf1t', 'PreserveVariableNames', true);

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

textLabel = uilabel(uiGrid, 'Text', 'Click a cell in the table:');

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'tbl');

dataTable.UserData = struct();

textLabelOut = uilabel(uiGrid, 'Text', 'Click the table',...
    'Tag', 'tbl_out');

% Callbacks
args = {...
    argsOut('tbl_out','children'),...
    argsIn('tbl','active_cell')};
handle = 'update_graphs';

callbackDat = {args, handle};

% Run the app
startDash(uiGrid, 8057, callbackDat);