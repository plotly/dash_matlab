terminate(pyenv);
clearvars;

md = sprintf(['',...
    '#### Dash and Markdown\n',...
    'Dash supports [Markdown](http://commonmark.org/help).\n',...
    'Markdown is a simple way to write and format text.\n',...
    'It includes a syntax for things like **bold text** and *italics*,\n',...
    '[links](http://commonmark.org/help), inline `code` snippets, lists,\n',...
    'quotes, and more.',...
    '']);

dashMd = Dcc('Markdown', {'children', md});

components = {dashMd};

% Start app
startDash(components, 8057, [], 'SOLAR');