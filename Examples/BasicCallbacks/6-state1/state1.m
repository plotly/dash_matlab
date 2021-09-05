terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create ui grid.
uifig = uifigure('visible', 'on');
size = [12, 12];
uigrid = uigridlayout(uifig, size);

textLeft = uitextarea(uigrid, 'Tag', 'input-1', 'Value', 'Montréal');
textLeft.Layout.Row = 1;
textLeft.Layout.Column= [1 4];

textRight = uitextarea(uigrid, 'Tag', 'input-2', 'Value', 'Canada');
textRight.Layout.Row = 1;
textRight.Layout.Column= [5 8];

labelOutput = uilabel(uigrid, 'Tag', 'number-output');
labelOutput.Layout.Row = [2, 12];

% Define callbacks.
args = {argsOut("number-output", "children"), ...
    argsIn("input-1", "value"), argsIn("input-2", "value")};

handle = 'update_output';
callbackDat = {args, handle};

% Start app.
app = startDash(uigrid, 8057, callbackDat);