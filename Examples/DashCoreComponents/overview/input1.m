terminate(pyenv);
clearvars;

dashInput = Dcc('Input', {...
    'placeholder', 'Enter a value...',...
    'type', 'text',...
    'value', ''});

components = {dashInput};

% Start app
startDash(components, 8057, [], 'SOLAR');