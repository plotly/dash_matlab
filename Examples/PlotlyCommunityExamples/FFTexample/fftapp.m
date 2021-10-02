terminate(pyenv);
clearvars;

% create Dash app
app = createApp();

uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

% Initial Plot
ax = axes(uiGrid);
ax.Tag = 'my-plot';

% Toggle FFT switch
switchButton = uiswitch(uiGrid, 'Tag', 'my-switch');
switchButton.Layout.Row = 1;
switchButton.Layout.Column = 8;

switchLabel = uilabel(uiGrid, 'Text', 'Touch to add/remove noise',...
    'FontSize', 14);
switchLabel.Layout.Row = 1;
switchLabel.Layout.Column = 8;

% Frequency 1
frequencySlider1 = uislider(uiGrid, 'Tag', 'freq-slider-1');
frequencySlider1.Value = 50;
frequencySlider1.MajorTicks = (0:25:500);
frequencySlider1.Layout.Row = 3;
frequencySlider1.Layout.Column = [1, 6];

frequencyLabel1 = uilabel(uiGrid, 'Text', 'Frequency 1',...
    'FontSize', 16, 'FontWeight', 'bold');
frequencyLabel1.Layout.Row = 2;
frequencyLabel1.Layout.Column = [2, 4];

% Frequency 2
frequencySlider2 = uislider(uiGrid, 'Tag', 'freq-slider-2');
frequencySlider2.Limits = [0 140];
frequencySlider2.Value = 125.0;
frequencySlider2.MajorTicks = (0:25:500);
frequencySlider2.Layout.Row = 3;
frequencySlider2.Layout.Column = [7, 12];

frequencyLabel1 = uilabel(uiGrid, 'Text', 'Frequency 2',...
    'FontSize', 16, 'FontWeight', 'bold');
frequencyLabel1.Layout.Row = 2;
frequencyLabel1.Layout.Column = [9, 11];

% Amplitude 1
amplitudeSlider1 = uislider(uiGrid, 'Tag', 'ampl-slider-1');
amplitudeSlider1.Value = 0.7;
amplitudeSlider1.MajorTicks = (0:0.1:2);
amplitudeSlider1.Layout.Row = 5;
amplitudeSlider1.Layout.Column = [1, 6];

amplitudeLabel1 = uilabel(uiGrid, 'Text', 'Amplitude 1',...
    'FontSize', 16, 'FontWeight', 'bold');
amplitudeLabel1.Layout.Row = 4;
amplitudeLabel1.Layout.Column = [2, 4];

% Amplitude 2
amplitudeSlider2 = uislider(uiGrid, 'Tag', 'ampl-slider-2');
amplitudeSlider2.Value = 1.0;
amplitudeSlider2.MajorTicks = (0:0.1:2);
amplitudeSlider2.Layout.Row = 5;
amplitudeSlider2.Layout.Column = [7, 12];

amplitudeLabel2 = uilabel(uiGrid, 'Text', 'Amplitude 2',...
    'FontSize', 16, 'FontWeight', 'bold');
amplitudeLabel2.Layout.Row = 4;
amplitudeLabel2.Layout.Column = [9, 11];

args = {...
    argsOut('my-plot', 'figure'),...
    argsIn('freq-slider-1','value'),...
    argsIn('freq-slider-2','value'),...
    argsIn('ampl-slider-1','value'),...
    argsIn('ampl-slider-2','value'),...
    argsIn('my-switch','on')};  
handle = 'updateGraph'; % Callback function

callbackDat = {args, handle};

% run the app
startDash(uiGrid, 8057, callbackDat);