terminate(pyenv);
clearvars;

dashSlider = Dcc('Slider', {...
    'id', 'my-slider',...
    'min',0,'max',20,'step',0.5,...
    'value', 10});

myDiv = Html('Div', {'id', 'slider-output-container'});

components = {dashSlider, myDiv};

% Callbacks
args = {argsOut('slider-output-container', 'children'), ...
    argsIn('my-slider', 'value') };
handle = 'update_output';
callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');