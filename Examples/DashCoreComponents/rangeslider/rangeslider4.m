terminate(pyenv);
clearvars;

dashRangeslider = Dcc('RangeSlider', {...
    'min',0,'max',30,...
    'value', {1, 3, 4, 5, 12, 17}});

components = {dashRangeslider};

% Start app
startDash(components, 8057, [], 'SOLAR');