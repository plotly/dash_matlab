clear all
close all
terminate(pyenv);

% read data file

tab = readtable('ind.csv');
all_inds = unique(tab.IndicatorName);

% create Dash app

slider_app = createApp();

% create ui elements

tics = unique(tab.Year);
uifig = uifigure('visible', 'off');
sld = uislider(uifig);
sld.MajorTicks = tics;
dropd1 = uidropdown(uifig, 'Items', all_inds, 'Value', all_inds{1});
dropd2 = uidropdown(uifig, 'Items', all_inds, 'Value', all_inds{2});

bg1 = uibuttongroup(uifig);   
rb11 = uiradiobutton(bg1);
rb12 = uiradiobutton(bg1);
rb11.Text = 'lin';
rb12.Text = 'log';

bg2 = uibuttongroup(uifig);   
rb21 = uiradiobutton(bg2);
rb22 = uiradiobutton(bg2);
rb21.Text = 'lin';
rb22.Text = 'log';

%convert ui elements to dash
dash_sld1 = ui2dash(sld, 'year-slider');
dash_butgroup1 = ui2dash(bg1, 'xaxis-type');
dash_butgroup2 = ui2dash(bg2, 'yaxis-type');
dash_dropd1 = ui2dash(dropd1, 'xaxis-column');
dash_dropd2 = ui2dash(dropd2, 'yaxis-column');

%initial plot
fig = figure('visible', 'off');
subtab = tab(tab.Year == tics(1), :);

close(uifig)
close(fig)
subtab1 = subtab(cellfun(@(x) isequal(x,all_inds{1}), subtab.IndicatorName), : );
subtab2 = subtab(cellfun(@(x) isequal(x,all_inds{2}), subtab.IndicatorName), : );
scatter(subtab1.Value,  subtab2.Value, categorical(subtab2.Value));

fig = plotlyfig2dash(fig2plotly(gcf, 'offline', true, 'open', false,'Visible', false), 'indicator-graphic');

% add slider and graph to Dash app layout

slider_app.layout = addLayout(py.dash_html_components.Div({ ...
    py.dash_html_components.Div({dash_dropd1, dash_butgroup1}, ...
    pyargs('style', py.dict(pyargs('width', '48%', 'display', 'inline-block')))),...
    py.dash_html_components.Div({dash_dropd2, dash_butgroup2}, ...
    pyargs('style', py.dict(pyargs('width', '48%','float','right', 'display', 'inline-block')))) }), ...
    py.dash_html_components.Div({fig, dash_sld1}));

% define the callbacks

slider_callback = slider_app.callback({ argsOut('indicator-graphic', 'figure'), ...
    argsIn('xaxis-column', 'value'), ...
    argsIn('yaxis-column', 'value'), ...
    argsIn('xaxis-type', 'value'), ...
    argsIn('yaxis-type', 'value'), ...
    argsIn('year-slider', 'value') });  
slider_callback(@py.callback.callback);

% run the app

slider_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
