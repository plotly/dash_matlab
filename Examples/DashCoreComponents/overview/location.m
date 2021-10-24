terminate(pyenv);
clearvars;

dashLocation = Dcc('Location',{'id', 'url', 'refresh', false});

components = {dashLocation};

% Start app
startDash(components, 8057, [], 'SOLAR');