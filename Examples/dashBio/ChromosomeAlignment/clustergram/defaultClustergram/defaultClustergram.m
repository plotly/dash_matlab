terminate(pyenv);
clearvars;

df = readBioData('https://git.io/Ja6zV', 'dataframe',...
    {'sep', '\t', 'skiprows', int8(4)}).set_index('model');
row_labels = py.list(df.index.values);
row_labels = cell(row_labels);

options = {};

for row=row_labels
    options{end+1} = struct('label', string(row{1}), 'value', string(row{1}));
end

%options = {options};
%options

a = row_labels(1:10);
b = {};
for i=1:length(a)
    b{end+1} = string(a{i});
end
b;
a{1};
%asd

dropdown = Dcc('Dropdown',{...
    'id', 'my-default-clustergram-input',...
    'options', options,...
    'value', b,...
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