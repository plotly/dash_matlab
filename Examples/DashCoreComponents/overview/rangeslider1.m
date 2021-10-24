terminate(pyenv);
clearvars;

dashRangeslider = Dcc('RangeSlider', {...
    'count', 1,...
    'min',-5,'max',10, 'step', 0.5,...
    'value', {-3, 7}});

components = {dashRangeslider};

% Start app
startDash(components, 8057, [], 'SOLAR');