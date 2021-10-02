
tsunamis = readtable('tsunamis.xlsx');
tsunamis.Cause = categorical(tsunamis.Cause);
geobubble(tsunamis,'Latitude','Longitude', ...
    'SizeVariable','MaxHeight','ColorVariable','Cause');

fig2plotly(gcf, 'offline', false);


%{
tsunamis = readtable('tsunamis.xlsx');
tsunamis.Cause = categorical(tsunamis.Cause);
ax(1) = geobubble(tsunamis,'Latitude','Longitude', ...
    'SizeVariable','MaxHeight','ColorVariable','Cause')
fig = gcf;
fig.Position = [100 100 900 500]
%for some reason you have to add this invisible axes before axesm
axes('visible','off')
ax(2) = axesm('MapProjection','mercator',...
     'MapLatLimit',ax(1).LatitudeLimits,...
     'MapLonLimit',ax(1).LongitudeLimits);
ax(2).Position = ax(1).Position
plotm(tsunamis{:,1},tsunamis{:,2},'o')
ax(2).Color = 'none';
shg
hold off
%}