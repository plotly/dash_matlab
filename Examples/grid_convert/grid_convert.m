close all
terminate(pyenv)

tab = readtable('ind.csv');
all_inds = unique(tab.IndicatorName);

% create ui elements
tics = unique(tab.Year);
uifig = uifigure('visible', 'on');
sz = [12, 12];
uigr = uigridlayout(uifig, sz);

sld = uislider(uigr);
sld.MajorTicks = tics;
sld.Layout.Row=12;
sld.Layout.Column=[1, 12];
sld.Tag = "year-slider";

dropd1 = uidropdown(uigr, 'Items', all_inds, 'Value', all_inds{1});
dropd1.Layout.Row=1;
dropd1.Layout.Column=[1, 6];
dropd1.Tag = "xaxis-column";

dropd2 = uidropdown(uigr, 'Items', all_inds, 'Value', all_inds{2});
dropd2.Layout.Row=1;
dropd2.Layout.Column=[7, 12];
dropd2.Tag = "yaxis-column";

bg1 = uibuttongroup(uigr);   
bg1.Tag = "xaxis-type";
bg1.Layout.Row=2;
bg1.Layout.Column=1;

rb1 = uiradiobutton(bg1);
rb1.Text = 'Linear';

rb2 = uiradiobutton(bg1);
rb2.Text = 'Log';

bg2 = uibuttongroup(uigr);   
bg2.Tag = "yaxis-type";
bg2.Layout.Row=2;
bg2.Layout.Column=7;

rb3 = uiradiobutton(bg2);
rb3.Text = 'Linear';

rb4 = uiradiobutton(bg2);
rb4.Text = 'Log';

%initial plot
ax=axes(uigr);
ax.Layout.Row=[3, 11];
ax.Layout.Column=[1, 12];

subtab = tab(tab.Year == tics(1), :);
subtab1 = subtab(cellfun(@(x) isequal(x,all_inds{1}), subtab.IndicatorName), : );
subtab2 = subtab(cellfun(@(x) isequal(x,all_inds{2}), subtab.IndicatorName), : );
scatter(ax, subtab1.Value,  subtab2.Value, categorical(subtab2.Value));
ax.Tag = "indicator-graphic";

%define callback
args = { argsOut("indicator-graphic", 'figure'), ...
    argsIn("xaxis-column", 'value'), ...
    argsIn('yaxis-column', 'value'), ...
    argsIn('xaxis-type', 'value'), ...
    argsIn('yaxis-type', 'value'), ...
    argsIn('year-slider', 'value') };
handle = @py.callback.callback;  %callback function handle
callback_dat = {args, handle};

% start dash server
app=start_dash(uigr, 8057, callback_dat);
