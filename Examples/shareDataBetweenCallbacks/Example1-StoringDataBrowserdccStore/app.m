clear all
close all
terminate(pyenv);

global_df = readtable('...');
appEx1 = createApp();

appEx1.layout = addLayout();

appEx1.layout = addLayout(py.dash_html_components.Div({...
    py.dash_core_components.Graph('id','graph'),...
    py.dash_html_components.Table('id','table'),...
    py.dash_core_components.Dropdown('id','dropdown'),...   
    py.dash_core_components.Store('id','intermediate-value')}));


% define the callbacks

first_callback = appEx1.callback({ argsOut('intermediate-value', 'data'), ...
    argsIn('dropdown', 'value') });  
first_callback(@py.callback.callback1);

second_callback = appEx1.callback({ argsOut('graph', 'figure'), ...
    argsIn('intermediate-value', 'data') });  
second_callback(@py.callback.callback2);

third_callback = appEx1.callback({ argsOut('table', 'children'), ...
    argsIn('intermediate-value', 'data') });  
third_callback(@py.callback.callback3);

% run the app

appEx1.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))