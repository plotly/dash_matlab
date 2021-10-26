terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

uiFig = uifigure('visible', 'off');
uiGrid = uigridlayout(uiFig);

img_1 = uiimage(uiGrid);
img_1.ImageSource = 'assets/plotly-logo.png';
dashImg = ui2dash(img_1, 'img_1');

components = {dashImg};

% Run the app.
startDash(uiGrid, 8057, [], 'DARKLY');
