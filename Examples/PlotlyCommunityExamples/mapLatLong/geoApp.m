terminate(pyenv);
clearvars;

% create Dash app
app = createApp();

uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

label = uilabel(uiGrid, 'Text', 'hola label');
% Figure
%p = uipanel(uiGrid, 'Tag', 'hola panel');

%fig = figure('visible', 'off');
%ax = axes(uiGrid);
%fig = figure('visible', 'off');
%t = (0:0.02:2*pi);
%plot(ax, t, sin(2*pi*1*t));
%ax.Tag = 'my-plot';


tsunamis = readtable('tsunamis.xlsx');
tsunamis.Cause = categorical(tsunamis.Cause);

gb = geobubble(uiFigure, tsunamis,'Latitude','Longitude', ...
    'SizeVariable','MaxHeight','ColorVariable','Cause');

%uiGrid.Children(2)
%asd
%fig2plotly(gcf, 'offline', false);

% run the app
startDash(uiGrid, 8057);