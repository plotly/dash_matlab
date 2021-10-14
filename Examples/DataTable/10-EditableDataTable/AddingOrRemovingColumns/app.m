clear all
close all
terminate(pyenv);

% Define data table
Column1 = [0:1:4]';
Column2 = [5:1:9]';
Column3 = [10:1:14]';
Column4 = [15:1:19]';
data = table(Column1,Column2,Column3,Column4);

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'editing-columns');

% Define custom columns
columns = {4};
for i=1:4
    columns{i} = struct(...
        'name', sprintf('Column %s', string(i)),...
        'id', sprintf('Column%s', string(i)),...
        'deletable', true,...
        'renamable', true);
end
columns = {columns};

% User data
dataTable.UserData = struct(...
    'columns', columns,...
    'editable', true); % Use -1 to prevent the tooltip from disappearing

% Input field
inp = uieditfield(uifig);
inp.Value = '';
inp.Placeholder = 'Enter a column name...';
inp.Tag = 'editing-columns-name';

% Button
btn = uibutton(uifig);
btn.Text = 'Add Column';
btn.Tag = 'editing-columns-button';

graph = py.dash_core_components.Graph(pyargs(...
    'id', 'editing-columns-graph'));

% add table to Dash app layout
table_app.layout = addLayout(divEdit, dash_table, graph);

% Callbacks

cols_callback = table_app.callback({argsOut('editing-columns','columns'),...
    argsIn('editing-columns-button','n_clicks'),...
    argsIn('editing-columns-name','value'),...
    argsIn('editing-columns','columns')});
cols_callback(@py.callback.callback1);

disp_callback = table_app.callback({argsOut('editing-columns-graph','figure'),...
    argsIn('editing-columns','data'),...
    argsIn('editing-columns','columns')});
disp_callback(@py.callback.callback2);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))