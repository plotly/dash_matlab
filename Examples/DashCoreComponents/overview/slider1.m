terminate(pyenv);
clearvars;

dashSlider = Dcc('Slider', {...
    'min',-5,'max',10,'step',0.5,'value',-3});

components = {dashSlider};

% Start app
startDash(components, 8057, [], 'SOLAR');