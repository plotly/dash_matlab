%%
clear;close all; clc
terminate(pyenv);
%% Read the data 
% Uncomment the below line if you want to download the data
% data = webread('https://plotly.github.io/datasets/country_indicators.csv');
% Use below line if you downloaded the data locally
data = PrepareData("country_indicators.csv", [2, Inf]);
data.IndicatorName = string(data.IndicatorName);
data.CountryName = string(data.CountryName);
available_indicators = unique(data.IndicatorName);
%% Create UI 
uifig = uifigure('Visible', 'off');

%% Group 1 : X axis
% drow down 1 
indicator_uidd1 = uidropdown(uifig, 'items', available_indicators, ...
'Value', available_indicators(7));
indicator_uidd_dash = ui2dash(indicator_uidd1, "Xaxis_dd");

% Radio button group 1
ButtonGroup1 = uibuttongroup(uifig);
% Create LinearButton
LinearButton = uiradiobutton(ButtonGroup1);
LinearButton.Text = 'Linear';
% Create LogButton
LogButton = uiradiobutton(ButtonGroup1);
LogButton.Text = 'Log';
% Create HTML Div for X axis group
indicator_uiradio_dash = ui2dash(ButtonGroup1, "Xaxis_radio");
style1 = py.dict(pyargs('width', '49%', 'display', 'inline-block'));
group1 = {indicator_uidd_dash, indicator_uiradio_dash};
div1 = py.dash_html_components.Div(pyargs('children', group1, 'style', style1));

 %% Group 2 : Y axis 
% drow down 2 
indicator_uidd2 = uidropdown(uifig, 'items', available_indicators, 'Value', available_indicators(12));
indicator_uidd_dash2 = ui2dash(indicator_uidd2, "Yaxis_dd");
% Radio button group 2
ButtonGroup2 = uibuttongroup(uifig);
% Create LinearButton
LinearButton2 = uiradiobutton(ButtonGroup2);
LinearButton2.Text = 'Linear';
% Create LogButton
LogButton2 = uiradiobutton(ButtonGroup2);
LogButton2.Text = 'Log';
indicator_uiradio_dash2 = ui2dash(ButtonGroup2, "Yaxis_radio");
% Create HTML Div for Y axis group
style2 = py.dict(pyargs('width', '49%', 'display', 'inline-block'));
group2 = {indicator_uidd_dash2, indicator_uiradio_dash2};
div2 = py.dash_html_components.Div(pyargs('children', group2, 'style', style2));
style = py.dict(pyargs('padding', '10px 5px'));                                                                     
group = py.dash_html_components.Div(pyargs('children', {div1, div2}, ...
                                                                                          'style', style, ...
                                                                                          'id', 'figure-axis-div'));
                                                                                      
%% Years slider
years_min  = min(data.Year);
years_max = max(data.Year);
years_range = years_max - years_min;
years_slider = uislider(uifig, 'Limits', [min(data.Year), max(data.Year)], ...
    'Value', max(data.Year), 'MajorTicks', years_min: round(.1 * years_range): years_max);
style_slider = py.dict(pyargs('width', '49%', 'padding', '0px 20px 20px 20px'));
years_slider_dash = ui2dash(years_slider, 'years_slider');
slider_div = py.dash_html_components.Div(pyargs('children', {years_slider_dash}, ... 
                                                                                              'style', style_slider, ...
                                                                                              'id', 'slider-div'));

%% Initial graph 1: Scatter plot (Y group Vs X group)
% Data at the required year
Data_Year = data(data.Year == years_slider.Value,:);
X = Data_Year(Data_Year.IndicatorName ==    indicator_uidd1.Value, :);
Y = Data_Year(Data_Year.IndicatorName ==    indicator_uidd2.Value, :);
Hover_Country = Y.CountryName;
f1 = figure('visible', 'off');
if ButtonGroup1.SelectedObject.Text == "Linear" && ButtonGroup1.SelectedObject.Text == "Linear"
        scatter(X.Value, Y.Value);
elseif ButtonGroup1.SelectedObject.Text == "Log" && ButtonGroup1.SelectedObject.Text == "Linear"
        scatter(log(X.Value), Y.Value);
elseif ButtonGroup1.SelectedObject.Text == "Linear" && ButtonGroup1.SelectedObject.Text == "Log"
        scatter(X.Value, log(Y.Value));
else
        scatter(log(X.Value), log(Y.Value));
end
xlabel([indicator_uidd1.Value ' Scale:  ' ButtonGroup1.SelectedObject.Text] );
ylabel([indicator_uidd2.Value ' Scale:  ' ButtonGroup1.SelectedObject.Text] );

title(['Scatter plot ' '('  indicator_uidd1.Value 'vs '  indicator_uidd2.Value ') at year = ' num2str(years_slider.Value)]);
grid('on');
fig1_plotly = fig2plotly(f1, 'offline', true, 'open', false,'Visible', false);
fig1 = plotlyfig2dash(fig1_plotly, ...
    'crossfilter-indicator-scatter');

fig1_style = py.dict(pyargs('width', '49%', 'display', 'inline-block', 'padding', '0 20'));
fig1_div = py.dash_html_components.Div(pyargs('children', {fig1}, ... 
                                                                                              'style', fig1_style, ...
                                                                                              'id', 'scatter-plot-div'));
%% Initial graph 2: 2 Line plots (X Time Series, Y Time Series) 
% Hard code Hover on Country , to be changed upon callbacks
Countries =  data.CountryName;
hovercountry_idx = 1;
hovered_country = Countries(hovercountry_idx);
Data_X_Country = data(data.CountryName == hovered_country & data.IndicatorName ==    indicator_uidd1.Value,:);
Data_Y_Country = data(data.CountryName == hovered_country & data.IndicatorName ==    indicator_uidd2.Value, :);
f2 = figure('visible', 'off');
subplot(2,1,1)
plot(Data_X_Country.Year, Data_X_Country.Value);
xlabel('Year');
ylabel('Value');
title(['Time series for ' char(indicator_uidd1.Value) ' at ' char(hovered_country)])
grid('on');

subplot(2,1,2)
plot(Data_Y_Country.Year, Data_Y_Country.Value);
xlabel('Year');
ylabel('Value');
title(['Time series for ' char(indicator_uidd2.Value) ' at ' char(hovered_country)])
grid('on');
fig2_b_plotly = fig2plotly(f2, 'offline', true, 'open', false,'Visible', false);
fig2_b = plotlyfig2dash(fig2_b_plotly, 'x-y-time-series');
fig2_style = py.dict(pyargs('display', 'inline-block', 'width', '49%'));
fig2_div = py.dash_html_components.Div(pyargs('children', {fig2_b}, ... 
                                                                                              'style', fig2_style, ...
                                                                                              'id', 'ts-div'));
fig_div =   py.dash_html_components.Div(pyargs('children', {fig1_div, fig2_div}, ... 
                                                                                              'style', style, ...
                                                                                              'id', 'figures-div'));                                                                                        
                                                                                        
%% Create the app
Hover_app = createApp();
Hover_app.layout = addLayout(py.dash_html_components.Div({group, fig_div, slider_div}));


%% Callbacks

InputArgs1 = argsIn('years_slider', 'value');
InputArgs2 = argsIn('Xaxis_dd', 'value');
InputArgs3 = argsIn('Yaxis_dd', 'value');
InputArgs4 = argsIn('crossfilter-indicator-scatter', 'hoverData');
InputArgs5 = argsIn('Xaxis_radio', 'value');
InputArgs6 = argsIn('Yaxis_radio', 'value');

OutputArgs1 = argsOut('crossfilter-indicator-scatter', 'figure');
OutputArgs2 = argsOut('x-y-time-series', 'figure');

Hover_app_callback = Hover_app.callback({OutputArgs1, OutputArgs2, InputArgs1, InputArgs2, ...
    InputArgs3, InputArgs4, InputArgs5, InputArgs6});
Hover_app_callback(@py.callback.callback);


%% run the app

Hover_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))