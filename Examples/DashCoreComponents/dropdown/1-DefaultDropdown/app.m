terminate(pyenv);
clearvars;

allInds = {'New York City'; 'Montreal'; 'San Francisco'};

% create ui elements
uiFig = uifigure('visible', 'off');

uiDropdown = uidropdown(uiFig, 'Items', allInds, 'Value', allInds{1});
dashDropdown = ui2dash(uiDropdown, 'demo-dropdown');

dashText = Html('Div', {'id', 'dd-output-container'});

% Add dropdown to Dash app layout
components = {dashDropdown, dashText};

% Define the callbacks
args = { ...
    argsOut('dd-output-container', 'children'),...
    argsIn('demo-dropdown', 'value')};
handle = 'update_output';

callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');