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

dropd1 = uidropdown(uigr, 'Items', all_inds, 'Value', all_inds{1});
dropd1.Layout.Row=1;
dropd1.Layout.Column=[1, 6];
dropd2 = uidropdown(uigr, 'Items', all_inds, 'Value', all_inds{2});
dropd2.Layout.Row=1;
dropd2.Layout.Column=[7, 12];

bg1 = uibuttongroup(uigr);   
rb1 = uiradiobutton(bg1);
rb1.Text = 'Linear';
bg1.Layout.Row=2;
bg1.Layout.Column=[1, 2];

bg2 = uibuttongroup(uigr);   
rb2 = uiradiobutton(bg2);
rb2.Text = 'Log';
bg2.Layout.Row=3;
bg2.Layout.Column=[1, 2];

bg3 = uibuttongroup(uigr);   
rb3 = uiradiobutton(bg3);
rb3.Text = 'Linear';
bg3.Layout.Row=2;
bg3.Layout.Column=[7, 8];

bg4 = uibuttongroup(uigr);   
rb4 = uiradiobutton(bg4);
rb4.Text = 'Log';
bg4.Layout.Row=3;
bg4.Layout.Column=[7, 8];

ax=axes(uigr);
ax.Layout.Row=[4, 11];
ax.Layout.Column=[1, 12];
plot(ax, 1:10, 1:10)

% start dash server
app=start_dash(uigr, 8057);
