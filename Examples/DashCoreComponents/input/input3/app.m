terminate(pyenv);
clearvars;

dashInput1 = Dcc('Input', {...
    'id', 'dfalse',...
    'type', 'number',...
    'placeholder', 'Debounce False'});

dashInput2 = Dcc('Input', {...
    'id', 'dtrue',...
    'type', 'number',...
    'debounce', true,...
    'placeholder', 'Debounce True'});

dashInput3 = Dcc('Input', {...
    'id', 'input_range_2',...
    'type', 'number',...
    'placeholder', 'input with range',...
    'min', 10, 'max', 100, 'step', 3});

dashHr = Html('Hr');

dashDiv = Html('Div', {'id', 'number-out'});

components = {dashInput1, dashInput2, dashInput3, dashHr, dashDiv};

% Callbacks

args = {argsOut('number-out', 'children'),...
    argsIn('dfalse', 'value'),...
    argsIn('dtrue', 'value'),...
    argsIn('input_range_2', 'value')};
handle = 'number_render';
callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');