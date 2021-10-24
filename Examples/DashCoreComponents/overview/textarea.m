terminate(pyenv);
clearvars;

dashTextarea = Dcc('Textarea', {...
    'placeholder', 'Enter a value...',...
    'value', 'This is a TextArea component',...
    'style', struct('width', '100%')});

components = {dashTextarea};

% Start app
startDash(components, 8057, [], 'SOLAR');
