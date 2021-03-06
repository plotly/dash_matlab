terminate(pyenv);
clearvars;

uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

% Initial Plot
ax = axes(uiGrid);
ax.Tag = 'my-plot';

% Frequency
frequencySlider = uislider(uiGrid, 'Tag', 'freq-slider');
frequencySlider.Value = 1.5;
frequencySlider.MajorTicks = (0:0.3:3);
frequencySlider.Layout.Row = 2;
frequencySlider.Layout.Column = [1, 6];

frequencyLabel = uilabel(uiGrid, 'Text', 'Frequency',...
    'FontSize', 16, 'FontWeight', 'bold', 'FontColor', 'white');
frequencyLabel.Layout.Row = 3;
frequencyLabel.Layout.Column = 4;

% Amplitude
amplitudeSlider = uislider(uiGrid, 'Tag', 'ampl-slider');
amplitudeSlider.Value = 3;
amplitudeSlider.MajorTicks = (1:1:10);
amplitudeSlider.Layout.Row = 2;
amplitudeSlider.Layout.Column = [7, 12];

amplitudeLabel = uilabel(uiGrid, 'Text', 'Amplitude',...
    'FontSize', 16, 'FontWeight', 'bold', 'FontColor', 'white');
amplitudeLabel.Layout.Row = 3;
amplitudeLabel.Layout.Column = 9;

% Define the callbacks
args = {...
    argsOut('my-plot', 'figure'),...
    argsIn('freq-slider','value'),...
    argsIn('ampl-slider','value')};  
handle = 'updateGraph'; % Callback function

callbackDat = {args, handle};

% Run the app
startDash(uiGrid, 8057, callbackDat, 'SOLAR');