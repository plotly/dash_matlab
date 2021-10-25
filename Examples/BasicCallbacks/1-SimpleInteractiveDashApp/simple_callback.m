terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

uifig = uifigure('visible', 'off');
size = [12, 12];
uigrid = uigridlayout(uifig, size);

textHeader = uilabel(uigrid,...
    'Text', 'Change the value in the text box to see callbacks in action!',...
    'FontSize', 18, 'FontWeight', 'bold',...
    'FontColor', 'white');

textInput = uilabel(uigrid, 'Text', 'Input: ', 'FontColor', 'white');
textInput.Layout.Row = 2;
textInput.Layout.Column = 1;

inputEditField = uieditfield(uigrid,...
    'Value', 'initial value', 'Tag', 'my-input');
inputEditField.Layout.Row = 2;

textOutput = uilabel(uigrid, 'Tag', 'my-output', 'FontColor', 'white');
textOutput.Layout.Row = 3;

% Define the callbacks.
args = {...
    argsOut('my-output', 'children'),...
    argsIn('my-input','value')};

handle = 'update_output_div';

callbackDat = {args, handle};

% Run the app.
app = startDash(uigrid, 8057, callbackDat, 'DARKLY');
