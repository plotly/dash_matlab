terminate(pyenv);
clearvars;

df = readBioData('https://git.io/Ja6zV', 'dataframe',...
    {'sep', '\t', 'skiprows', int8(4)}).set_index('model');
data = df.values;

cols = py.list(df.columns.values);
rowLabels = py.list(df.index.values);

clustergram = dashBio(...
        'Clustergram',{...
            'data', data,...
            'row_labels', rowLabels,... 
            'column_labels', cols,...            
            'color_threshold', struct(...
                'row', 250,...
                'col', 700),...
            'height', 800,...
            'width', 700,...
            'hidden_labels', 'row'});

component = Dcc('Graph',{...
    'figure', clustergram});  
    
components = {component};

% Run the app
startDash(components, 8057);