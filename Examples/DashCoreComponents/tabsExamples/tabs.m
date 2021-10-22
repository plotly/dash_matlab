terminate(pyenv);
clearvars;

% Create ui grid
uiFig = uifigure('visible', 'on');
sz = [12, 12];
uiGrid = uigridlayout(uiFig, sz);

% Create tab group with tabs
tabGroup = uitabgroup(uiGrid);
tabGroup.Layout.Row = [1 8];
tabGroup.Layout.Column = [1 8];
tabMember = uitab(tabGroup,'Title','Member Information');
tabMe = uitab(tabGroup,'Title','Me');
dropdownComp = uidropdown(tabMember,'Items',{'Male','Female'});
dropdownComp.Position = [100 200 100 20];
checkboxComp = uicheckbox(tabMe,'Text','Member');

% Add axes
ax = axes(tabMember);
ax.Position = [0.13 .11 .77 .5];
plot(ax, 1:10, rand(10,1))
ax.UserData = struct('theme', 'plotly_dark');

ax = axes(tabMe);
ax.Position = [0.13 .11 .77 .5];
plot(ax, 1:10, rand(10,1))
ax.UserData = struct('theme', 'plotly_dark');

% Start app
startDash(uiGrid, 8057, [], 'SOLAR');
