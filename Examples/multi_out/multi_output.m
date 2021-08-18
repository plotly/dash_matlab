clear all
close all
terminate(pyenv);

%create ui grid
uifig = uifigure('visible', 'off');
sz = [12, 12];
uigr = uigridlayout(uifig, sz);

%edit field
fl = uieditfield(uigr, 'numeric');
fl.UserData = "num-multi";
fl.Value = 5;
fl.Layout.Row = 1;
fl.Layout.Column = 1;
%create uitable
table = uitable(uigr);
table.Layout.Row = [2 8];
table.Layout.Column = [1 8];
table.Data  = ["x^2" ""; "x^3" "";"2^x" "";"3^x" "";"x^x" ""];
table.UserData = ["" "square";"" "cube";"" "twos";"" "threes";"" "x^x"];

%define callback
args = {argsOut("square", 'children'), ...
    argsOut("cube", 'children'), ...
    argsOut("twos", 'children'), ...
    argsOut("threes", 'children'), ...
    argsOut("x^x", 'children'), ...
    argsIn("num-multi", 'value') };
handle = @py.callback.callback;  %callback function handle
callback_dat = {args, handle};

%start app
app=start_dash(uigr, 8057, callback_dat);

