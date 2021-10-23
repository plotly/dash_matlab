terminate(pyenv);
clearvars;

dashRangeslider = Dcc('RangeSlider', {...
    'min',0,'max',30,...
    'value', {8, 10, 15, 17, 20},...
    'pushable', 2});

components = {dashRangeslider};

% Start app
startDash(components, 8057, [], 'SOLAR');