clear all
close all
terminate(pyenv);

cities = py.dict(pyargs('America', {'New York City', 'San Francisco', 'Cincinnati'},...
    'Canada',{ 'Montréal', 'Toronto', 'Ottawa'}));
opt=py.list(cities.keys);

%create ui grid
uifig = uifigure('visible', 'on');
sz = [12, 12];
uigr = uigridlayout(uifig, sz);

bg1 = uibuttongroup(uigr);   
bg1.UserData = "countries-radio";
rb11 = uiradiobutton(bg1);
rb12 = uiradiobutton(bg1);
rb11.Text = string(opt{1});
rb12.Text = string(opt{2});
bg1.Layout.Row = [1 2];
bg1.Layout.Column= [1 2];
bg1.Children(2).Position=[10 30 91 22];

bg2 = uibuttongroup(uigr);  
bg2.UserData = "cities-radio";
bg2.Layout.Row = [3 5];
bg2.Layout.Column= [1 2];

txt = uitextarea(uigr);
txt.UserData = "display-selected-values";
txt.Layout.Row = 6;
txt.Layout.Column= [1 2];

%define callbacks
args = {argsOut('cities-radio', 'options'), ...
    argsIn('countries-radio', 'value') };
handle = @py.callback.callback1;  %callback function handle
callback_dat = {args, handle};

%define callbacks
args = {argsOut('cities-radio', 'value'), ...
    argsIn('cities-radio', 'options') };
handle = @py.callback.callback2;  %callback function handle
callback_dat{2,1} = args;
callback_dat{2,2} = handle;

%define callbacks
args = {argsOut('display-selected-values', 'value'), ...
    argsIn('countries-radio', 'value'),  argsIn('cities-radio', 'value') };
handle = @py.callback.callback3;  %callback function handle
callback_dat{3,1} = args;
callback_dat{3,2} = handle;

%start app
app=start_dash(uigr, 8057, callback_dat);

