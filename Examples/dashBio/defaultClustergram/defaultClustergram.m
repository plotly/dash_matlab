terminate(pyenv);
clearvars;

df = readBioData('https://git.io/Ja6zV', 'dataframe',...
    {'sep', '\t', 'skiprows', int8(4)}).set_index('model');
row_labels = py.list(df.index.values);
options = {};

for row=row_labels
    options{end+1} = struct('label', row, 'value', row);
end

dropdown = Dcc('Dropdown',{...
    'id', 'my-default-clustergram-input',...
    'options', options,...
    'value', row_labels(1:10),...
    'multi', true});

myDiv = Html('Div', {
    'id', 'my-default-clustergram'});
    
components = {dropdown, myDiv};

% Callbacks
args = {...
    argsOut('my-default-clustergram', 'children'),...
    argsIn('my-default-clustergram-input', 'value')};
handle = 'update_clustergram';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);