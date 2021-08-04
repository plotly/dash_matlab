clear all
close all
terminate(pyenv);

% define the callbacks

first_callback = appEx2.callback({ argsOut('intermediate-value', 'data'), ...
    argsIn('dropdown', 'value') });  
first_callback(@py.callback.callback1);

second_callback = appEx2.callback({ argsOut('graph', 'figure'), ...
    argsIn('intermediate-value', 'data') });  
second_callback(@py.callback.callback2);

third_callback = appEx2.callback({ argsOut('graph', 'figure'), ...
    argsIn('intermediate-value', 'data') });  
third_callback(@py.callback.callback3);

fourth_callback = appEx2.callback({ argsOut('graph', 'figure'), ...
    argsIn('intermediate-value', 'data') });  
fourth_callback(@py.callback.callback4);

% run the app

appEx2.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))