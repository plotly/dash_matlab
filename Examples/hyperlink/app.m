terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% add boxes to Dash app layout
uiFig = uifigure('visible', 'off');
uiGrid = uigridlayout(uiFig);

link_1 = uihyperlink(uiGrid);
link_1.URL = 'https://plotly.com/';
link_1.Text = 'Welcome to Plotly!';
dashLink = ui2dash(link_1, 'link_1');

components = {dashLink};

% Run the app.
startDash(uiGrid, 8057, [], 'DARKLY');
