terminate(pyenv);
clearvars;

x = [1 2 3];
city = {'SF'; 'Montreal'};

% Create tab group with tabs
uiFig = uifigure('visible', 'off');
tabGroup = uitabgroup(uiFig);

tabOne = uitab(tabGroup, 'Title', 'Tab One', 'Tag', 'one');
ax = axes(tabOne);
y = [4 2; 1 4; 2 5];
barChart = bar(ax, x, y);
set(barChart, {'DisplayName'}, city);
ax.UserData = struct('theme', 'plotly_dark');
ax.Tag = 'ax-one';

tabTwo = uitab(tabGroup, 'Title', 'Tab Two', 'Tag', 'two');
ax = axes(tabTwo);
y2 = [1 1; 4 2; 1 3];
barChart2 = bar(ax, x, y2);
set(barChart2, {'DisplayName'}, city);
ax.UserData = struct('theme', 'plotly_dark');
ax.Tag = 'ax-two';

tabThree = uitab(tabGroup, 'Title', 'Tab Three', 'Tag', 'three');
ax = axes(tabThree);
y = [2 5; 4 4; 3 3];
barChart = bar(ax, x, y);
set(barChart, {'DisplayName'}, city);
ax.UserData = struct('theme', 'plotly_dark');
ax.Tag = 'ax-three';

tabGroupComponent = ui2dash(tabGroup, 'tabs-example-graph');

components = {tabGroupComponent};

% Start app
startDash(components, 8057, [], 'SOLAR');
