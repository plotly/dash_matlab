terminate(pyenv);
clearvars;

% Read data files
modelData = readBioData('https://git.io/JV8hc', 'noutf8');
stylesData  = readBioData('https://git.io/JV4er', 'noutf8');

componentMolecule = dashBio('Molecule3dViewer', {...
        'id', 'dashbio-default-molecule3d',...
        'styles', stylesData,...
        'modelData', modelData});
    
Hr = Html('Hr');

divHtml = Html('Div', {'id', 'default-molecule3d-output',...
    'style', struct('whiteSpace','pre-line')});
    
components = {componentMolecule, Hr, divHtml};

% Callbacks
args = {...
    argsOut('default-molecule3d-output', 'children'),...
    argsIn('dashbio-default-molecule3d', 'selectedAtomIds')};
handle = 'show_selected_atoms';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);