terminate(pyenv);
clearvars;

% Add boxes to Dash app layout
uiFig = uifigure('visible', 'off');

myLabel = uilabel(uiFig);
myLabel.Text = 'This is a Label';
dashLabel = ui2dash(myLabel, 'label_1');


% add label to Dash app layout
components = {dashLabel};

% Start app
startDash(components, 8057, [], 'CERULEAN');
