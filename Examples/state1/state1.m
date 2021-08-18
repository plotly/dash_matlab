clear all
close all
terminate(pyenv);

%create ui grid
uifig = uifigure('visible', 'on');
sz = [12, 12];
uigr = uigridlayout(uifig, sz);

txt1 = uitextarea(uigr);
txt1.UserData = "input-1";
txt1.Value = "Montréal";
txt1.Layout.Row = 1;
txt1.Layout.Column= [1 4];

txt2 = uitextarea(uigr);
txt2.UserData = "input-2";
txt2.Value = "Canada";
txt2.Layout.Row = 1;
txt2.Layout.Column= [5 8];

lbl = uilabel(uigr);
lbl.UserData = "number-output";
lbl.Layout.Row = 2;
lbl.Layout.Column= [1 8];

%define callbacks
args = {argsOut("number-output", "children"), ...
    argsIn("input-1", "value") , argsIn("input-2", "value") };
handle = @py.callback.callback;  %callback function handle
callback_dat = {args, handle};

%start app
app=start_dash(uigr, 8057, callback_dat);

