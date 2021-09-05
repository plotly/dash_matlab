terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

% Read data file.
countryIndicators = readtable('country_indicators.csv');
allInds = unique(countryIndicators.IndicatorName);

% Create Dash app.
sliderApp = createApp();

uifig = uifigure('visible', 'off');
size = [12, 12];
uigrid = uigridlayout(uifig, size);

% Create ui elements.
dropdownLeft = uidropdown(uigrid, 'Tag', 'xaxis-column', 'Items', allInds, 'Value', allInds{1});
dropdownLeft.Layout.Column = [1, 6];

dropdownRight = uidropdown(uigrid, 'Tag', 'yaxis-column', 'Items', allInds, 'Value', allInds{2});
dropdownRight.Layout.Column = [7, 12];

buttonGroupLeft = uibuttongroup(uigrid, 'Tag', 'xaxis-type');   
buttonGroupLeft.Layout.Column = [1, 4];
radioButtonLeftLinear = uiradiobutton(buttonGroupLeft, 'Text', 'Linear');
radioButtonLeftLog = uiradiobutton(buttonGroupLeft, 'Text', 'Log');

buttonGroupRight = uibuttongroup(uigrid, 'Tag', 'yaxis-type');   
buttonGroupRight.Layout.Column = [7, 10];
radioButtonRightLinear = uiradiobutton(buttonGroupRight, 'Text', 'Linear');
radioButtonRightLog = uiradiobutton(buttonGroupRight, 'Text', 'Log');

% Initial plot.
ax = axes(uigrid);
ax.Layout.Row = [3, 11];
ax.Layout.Column = [2, 12];

fig = figure('visible', 'off');
tics = unique(countryIndicators.Year);
subtab = countryIndicators(countryIndicators.Year == tics(1), :);

subtabX = subtab(cellfun(@(x) isequal(x,allInds{1}), subtab.IndicatorName), : );
subtabY = subtab(cellfun(@(x) isequal(x,allInds{2}), subtab.IndicatorName), : );
scatter(ax, subtabX.Value,  subtabY.Value, categorical(subtabY.Value), 'filled',...
    'MarkerEdgeColor', 'b', 'MarkerFaceColor', [0 0.5 0.5]);
ax.Tag = 'indicator-graphic';

% Slider
slider = uislider(uigrid, 'Tag', 'year-slider', 'MajorTicks', tics);    

% Define the callbacks.
args = { argsOut('indicator-graphic', 'figure'), ...
    argsIn('xaxis-column', 'value'), ...
    argsIn('yaxis-column', 'value'), ...
    argsIn('xaxis-type', 'value'), ...
    argsIn('yaxis-type', 'value'), ...
    argsIn('year-slider', 'value') };  

handle = 'update_graph';
callbackDat = {args, handle};

% Run the app.
slider_app = startDash(uigrid, 8057, callbackDat);
