clear all
close all
terminate(pyenv);

%create ui grid
uifig = uifigure('visible', 'on');
sz = [12, 12];
uigr = uigridlayout(uifig, sz);

txt1 = uitextarea(uigr);
txt1.UserData = "input-1-state";
txt1.Value = "Montréal";
txt1.Layout.Row = 1;
txt1.Layout.Column= [1 4];

txt2 = uitextarea(uigr);
txt2.UserData = "input-2-state";
txt2.Value = "Canada";
txt2.Layout.Row = 1;
txt2.Layout.Column= [5 8];

but = uibutton(uigr);
but.Text = 'Submit';
but.UserData = "submit-button-state";
but.Layout.Row = 1;
but.Layout.Column= 9;

lbl = uilabel(uigr);
lbl.UserData = "output-state";
lbl.Layout.Row = 2;
lbl.Layout.Column= [1 8];

%define callbacks
args = {argsOut('output-state', 'children'), ...
    argsIn('submit-button-state', 'n_clicks') , ...
    argState('input-1-state', 'value'), ...
    argState('input-2-state', 'value') };
handle = @py.callback.callback;  %callback function handle
callback_dat = {args, handle};

%start app
app=start_dash(uigr, 8057, callback_dat);

