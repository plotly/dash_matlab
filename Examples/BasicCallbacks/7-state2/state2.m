terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create ui grid.
uifig = uifigure('visible', 'on');
size = [12, 12];
uigrid = uigridlayout(uifig, size);

textLeft = uitextarea(uigrid, 'Tag', 'input-1-state', 'Value', 'Montréal');
textLeft.Layout.Row = 1;
textLeft.Layout.Column= [1 4];

textRight = uitextarea(uigrid, 'Tag', 'input-2-state', 'Value', 'Canada');
textRight.Layout.Row = 1;
textRight.Layout.Column= [5 8];

button = uibutton(uigrid, 'Text', 'Submit', 'Tag', 'submit-button-state');
button.Layout.Row = 1;
button.Layout.Column= 9;

labelOutput = uilabel(uigrid, 'Tag', 'output-state',...
    'FontColor', 'white');
labelOutput.Layout.Row = 2;
labelOutput.Layout.Column= [1 8];

% Define callbacks.
args = {argsOut('output-state', 'children'), ...
    argsIn('submit-button-state', 'n_clicks') , ...
    argState('input-1-state', 'value'), ...
    argState('input-2-state', 'value') };

handle = 'update_output';
callbackDat = {args, handle};

% Start app.
app = startDash(uigrid, 8057, callbackDat);