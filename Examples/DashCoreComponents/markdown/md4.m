terminate(pyenv);
clearvars;

code = sprintf(['',...
    '> \n',...
    '> Block quotes are used to highlight text.\n',...
    '> ',...
    '']);

dashMd = Dcc('Markdown', {'children', code});

components = {dashMd};

% Start app
startDash(components, 8057, [], 'SOLAR');