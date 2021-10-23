terminate(pyenv);
clearvars;

dashRangeslider = Dcc('RangeSlider', {...
    'min',0,'max',30,...
    'value', {10, 15},...
    'allowCross', false});

components = {dashRangeslider};

% Start app
startDash(components, 8057, [], 'SOLAR');