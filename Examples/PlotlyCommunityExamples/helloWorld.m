terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

uiFigure = uifigure('visible', 'off');
uiGrid = uigridlayout(uiFigure);

% Title
title = uilabel(uiGrid, 'Text', 'Hello Dash!');
%title.FontSize = 24;
%title.FontWeight = 'bold';
%title.FontColor = 'red';
%title.HorizontalAlignment = 'center';

% Run the app.
%startDash(uiGrid, 8057, [], 'DARKLY');
startDash(uiGrid, 8057);