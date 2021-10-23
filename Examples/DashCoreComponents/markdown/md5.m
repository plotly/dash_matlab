terminate(pyenv);
clearvars;

code = sprintf(['',...
    '[Dash User Guide](/)',...
    '']);

dashMd = Dcc('Markdown', {'children', code});

components = {dashMd};

% Start app
startDash(components, 8057, [], 'SOLAR');