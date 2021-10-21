terminate(pyenv);
clearvars;

% Title
title = Html('H1', {'Dash Tabs component demo'});

% Create tab group with tabs
uiFig = uifigure('visible', 'off');
tabGroup = uitabgroup(uiFig);
tabOne = uitab(tabGroup,'Title','Tab One', 'Tag', 'tab-1-example-graph');
tabTwo = uitab(tabGroup,'Title','Tab Two', 'Tag', 'tab-2-example-graph');

tabGroupComponent = ui2dash(tabGroup, 'tabs-example-graph');

myDiv = Html('Div', {'id', 'tabs-content-example-graph'});

components = {title, tabGroupComponent, myDiv};

% Callbacks
args = {argsOut('tabs-content-example-graph', 'children'),...
    argsIn('tabs-example-graph', 'value')};
handle = 'render_content';

callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');
