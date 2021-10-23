terminate(pyenv);
clearvars;

dashSlider = Dcc('Slider', {...
    'min',0,'max',10,'step',1,'value',5,...
    'tooltip', struct(...
        'placement', 'bottom', 'always_visible', true)});

components = {dashSlider};

% Start app
startDash(components, 8057, [], 'SOLAR');