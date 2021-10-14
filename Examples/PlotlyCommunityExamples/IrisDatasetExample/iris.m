terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Create initial graph.
ax = axes('Tag', 'scatter-plot');
graph = ui2dash(ax);

% Slider title
sliderText = Html('H2', {'Petal Width'});

% Slider.
slider = uislider();
slider.UserData = struct(...
    'min', 0, 'max', 2.5, 'step', 0.1,...
    'marks', {{0, 2.5}},...
    'value', {{0.5, 2}});
uislider = ui2dash(slider, 'range-slider');

components = {graph, sliderText, uislider};

% Define the callbacks.
args = {argsOut('scatter-plot', 'figure'), argsIn('range-slider','value')};
handle = 'update_figure';
callbackDat = {args, handle};

% Run the app.
startDash(components, 8057, callbackDat, 'DARKLY');
