terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/JgqCd', 'PreserveVariableNames', true);

data.index = (1:1:height(data))';
data = movevars(data, 'index', 'Before', 'country');

PAGE_SIZE = 5;

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'datatable-paging-page-count');

dataTable.UserData = struct(...
    'page_current', 0,...
    'page_size', PAGE_SIZE,...
    'page_action', 'custom');

% Checkbox
chk = uicheckbox(uiGrid);
chk.Value = true;
chk.Text = 'Use page_count';
chk.Tag = 'datatable-use-page-count';

% Input field label
inpLabel = uilabel(uiGrid, 'Text', 'Page count: ');

% Input field
inp = uieditfield(uiGrid, 'numeric');
inp.Value = 20;
inp.Limits = [1 29];
inp.Tag = 'datatable-page-count';

% Callbacks

args1 = {...
    argsOut('datatable-paging-page-count','data'),...
    argsIn('datatable-paging-page-count','page_current'),...
    argsIn('datatable-paging-page-count','page_size')};
handle1 = 'update_table1';
callbackDat = {args1, handle1};

args2 = {...
    argsOut('datatable-paging-page-count','page_count'),...
    argsIn('datatable-use-page-count','value'),...
    argsIn('datatable-page-count','value')};
handle2 = 'update_table2';
callbackDat{2,1} = args2;
callbackDat{2,2} = handle2;

% Run the app
startDash(uiGrid, 8057, callbackDat);