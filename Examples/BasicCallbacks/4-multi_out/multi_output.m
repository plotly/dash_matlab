terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create ui grid.
uifig = uifigure('visible', 'off');
size = [12, 12];
uigrid = uigridlayout(uifig, size);

% Edit field.
editField = uieditfield(uigrid, 'numeric', 'Tag', 'num-multi', 'Value', 5);
editField.Layout.Row = 1;
editField.Layout.Column = 1;

% Create uitable.
table = uitable(uigrid);
table.Layout.Row = [2 8];
table.Layout.Column = [1 8];
table.Data  = ["x^2" ""; "x^3" "";"2^x" "";"3^x" "";"x^x" ""];
table.UserData = ["" "square";"" "cube";"" "twos";"" "threes";"" "x^x"];

% Define callback.
args = {argsOut("square", 'children'), ...
    argsOut("cube", 'children'), ...
    argsOut("twos", 'children'), ...
    argsOut("threes", 'children'), ...
    argsOut("x^x", 'children'), ...
    argsIn("num-multi", 'value') };

handle = 'callback_a';
callback_dat = {args, handle};

% Start app.
app = startDash(uigrid, 8057, callback_dat);