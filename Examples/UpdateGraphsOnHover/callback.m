function [plotlyfigs] = callback(year, xaxis, yaxis, hovercountry_idx, xscale, yscale)
%% Read the data 
% Uncomment the below line if you want to download the data
% data = webread('https://plotly.github.io/datasets/country_indicators.csv');
% Use below line if you downloaded the data locally
data = PrepareData("country_indicators.csv", [2, Inf]);
data.IndicatorName = string(data.IndicatorName);
data.CountryName = string(data.CountryName);
%% graph 1: Scatter plot (Y group Vs X group)
% Data at the required year
Data_Year = data(data.Year == year,:);
X = Data_Year(Data_Year.IndicatorName ==    xaxis, :);
Y = Data_Year(Data_Year.IndicatorName ==    yaxis, :);
f1 = figure('visible', 'off');
if xscale == "Linear" && yscale == "Linear"
        scatter(X.Value, Y.Value);
elseif xscale == "Log" && yscale == "Linear"
        scatter(log(X.Value), Y.Value);
elseif xscale == "Linear" && yscale == "Log"
        scatter(X.Value, log(Y.Value));
else
        scatter(log(X.Value), log(Y.Value));
end
xlabel([xaxis ' Scale:  ' xscale] );
ylabel([yaxis ' Scale:  ' yscale] );

title(['Scatter plot ' '('  xaxis 'vs '  yaxis ') at year = ' num2str(year)]);
grid('on');
fig1_plotly = fig2plotly(f1, 'offline', true, 'open', false,'Visible', false);
plotlyfig1 = jsonencode(fig1_plotly);

%% graph 2: 2 Line plots (X Time Series, Y Time Series)

Countries =  data.CountryName;
hovered_country = Countries(hovercountry_idx);
Data_X_Country = data(data.CountryName == hovered_country & data.IndicatorName ==    xaxis,:);
Data_Y_Country = data(data.CountryName == hovered_country & data.IndicatorName ==    yaxis, :);
f2 = figure('visible', 'off');
subplot(2,1,1)
plot(Data_X_Country.Year, Data_X_Country.Value);
xlabel('Year');
ylabel(xaxis);
title(['X Time series for ' char(xaxis) ' at ' char(hovered_country) ]);
grid('on');

subplot(2,1,2)
plot(Data_Y_Country.Year, Data_Y_Country.Value);
xlabel('Year');
ylabel(yaxis);
title(['Y Time series for ' char (yaxis) ' at ' char(hovered_country) ]);
grid('on');
fig2_plotly = fig2plotly(f2, 'offline', true, 'open', false,'Visible', false);
plotlyfig2 = jsonencode(fig2_plotly);
plotlyfigs = {plotlyfig1, plotlyfig2};
end