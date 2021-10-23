terminate(pyenv);
clearvars;

dashRangeslider = Dcc('RangeSlider', {...
    'id', 'my-range-slider',...
    'min',0,'max',20,'step',0.5,...
    'value', {5, 15}});

myDiv = Html('Div', {'id', 'output-container-range-slider'});

components = {dashRangeslider, myDiv};

% Callbacks
args = {argsOut('output-container-range-slider', 'children'), ...
    argsIn('my-range-slider', 'value') };
handle = 'update_output';
callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');