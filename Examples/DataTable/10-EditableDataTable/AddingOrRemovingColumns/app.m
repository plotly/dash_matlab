clear all
close all
terminate(pyenv);

% Define data table
Column1 = [0:1:4]';
Column2 = [5:1:9]';
Column3 = [10:1:14]';
Column4 = [15:1:19]';
data = table(Column1,Column2,Column3,Column4);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

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
uit.UserData = struct(...
    'columns', columns,...
    'editable', true); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'editing-columns');

% Input field
inp = uieditfield(uifig);
inp.Value = '';
inp.Placeholder = 'Enter a column name...';
input_txt = ui2dash(inp, 'editing-columns-name');

% Button
btn1 = uibutton(uifig);
btn1.Text = 'Add Column';
btn = ui2dash(btn1, 'editing-columns-button');

divEdit = py.dash_html_components.Div({input_txt, btn}, pyargs(...
    'style', struct('height', 50)));

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