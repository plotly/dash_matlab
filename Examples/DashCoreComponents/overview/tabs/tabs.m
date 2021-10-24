terminate(pyenv);
clearvars;

myTabs = Dcc('Tabs', {...
    'children', {...
        Dcc('Tab', {'label', 'Tab one', 'value', 'tab-1'}),...
        Dcc('Tab', {'label', 'Tab two', 'value', 'tab-2'})},...
    'id', 'tabs',...
    'value', 'tab-1'});
        

myDiv = Html('Div', {'id', 'tabs-content'});


components = {myTabs, myDiv};

% Callbacks
args = {argsOut('tabs-content', 'children'),...
    argsIn('tabs', 'value')};
handle = 'render_content';

callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');
