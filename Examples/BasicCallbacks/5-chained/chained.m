terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

cities = struct(...
    'America', {{'New York City', 'San Francisco', 'Cincinnati'}},...
    'Canada', {{'Montréal', 'Toronto', 'Ottawa'}});

countries = fieldnames(cities);

% Create ui grid.
uifig = uifigure('visible', 'on');
size = [12, 12];
uigrid = uigridlayout(uifig, size);

buttonGroupCountries = uibuttongroup(uigrid, 'Tag', 'countries-radio');   
radioButtonCountry1 = uiradiobutton(buttonGroupCountries, 'Text', string(countries{1}));
radioButtonCountry2 = uiradiobutton(buttonGroupCountries, 'Text', string(countries{2}));
buttonGroupCountries.Layout.Row = [1 2];
buttonGroupCountries.Layout.Column= [1 2];
buttonGroupCountries.Children(2).Position=[10 30 91 22];

buttonGroupCities = uibuttongroup(uigrid, 'Tag', 'cities-radio');  
buttonGroupCities.Layout.Row = [3 5];
buttonGroupCities.Layout.Column= [1 2];

textInfo = uitextarea(uigrid, 'Tag', 'display-selected-values');
textInfo.Layout.Row = 6;
textInfo.Layout.Column= [1 2];

% Define callbacks.
args1 = {argsOut('cities-radio', 'options'), ...
    argsIn('countries-radio', 'value') };
handle1 = 'set_cities_options';
callbackDat = {args1, handle1};

args2 = {argsOut('cities-radio', 'value'), ...
    argsIn('cities-radio', 'options') };
handle2 = 'set_cities_value';
callbackDat{2,1} = args2;
callbackDat{2,2} = handle2;

args3 = {argsOut('display-selected-values', 'value'), ...
    argsIn('countries-radio', 'value'),  argsIn('cities-radio', 'value') };
handle3 = 'set_display_children';
callbackDat{3,1} = args3;
callbackDat{3,2} = handle3;

% Start app.
app = startDash(uigrid, 8057, callbackDat);