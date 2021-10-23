terminate(pyenv);
clearvars;

dashH3 = Html('H3', {'Edit text input to see loading state'});

dashInput1 = Dcc('Input', {'id', 'loading-input-1',...
    'value', 'Input triggers local spinner'});

dashLoading1 = Dcc('Loading',{...
    'children', Html('Div', {'id', 'loading-output-1'}),...
    'id', 'loading-1', 'type', 'default'});

dashDiv1 = Html('Div', {{dashInput1, dashLoading1}});

dashInput2 = Dcc('Input', {'id', 'loading-input-2',...
    'value', 'Input triggers nested spinner'});

dashLoading2 = Dcc('Loading',{...
    'children', Html('Div', {'id', 'loading-output-2'}),...
    'id', 'loading-2', 'type', 'circle'});

dashDiv2 = Html('Div', {{dashInput2, dashLoading2}});

components = {dashH3, dashDiv1, dashDiv2};

% Callbacks
args1 = {argsOut('loading-output-1', 'children'), ...
    argsIn('loading-input-1', 'value') };
handle1 = 'input_triggers_spinner';
callbackDat = {args1, handle1};

args2 = {argsOut('loading-output-2', 'children'), ...
    argsIn('loading-input-2', 'value') };
handle2 = 'input_triggers_nested';
callbackDat{2,1} = args2;
callbackDat{2,2} = handle2;

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');