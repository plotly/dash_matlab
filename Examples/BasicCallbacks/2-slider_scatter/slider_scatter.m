terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create initial graph.
ax = axes('Tag', 'graph');
graph = ui2dash(ax);
centerGraph = Html('Center', {graph});

% Create slider.
slider = uislider();
slider.MajorTicks = [1952,1957,1962,1967,1972,1977,1982,1987,1992,1997,2002,2007];
uislider = ui2dash(slider, 'year');

Br = Html('Br');
Hr = Html('Hr', {'style', struct('border', '1px solid white')});

components = {centerGraph, Br, Hr, uislider};

% Define the callbacks.
args = {argsOut('graph', 'figure'), argsIn('year','value')};
handle = 'update_figure';
callbackDat = {args, handle};

% Run the app.
slider_app = startDash(components, 8057, callbackDat);
