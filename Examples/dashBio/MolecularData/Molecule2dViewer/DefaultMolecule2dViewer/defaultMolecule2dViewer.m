terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JV879');
model_data = jsondecode(char(data));

componentMolecule = dashBio('Molecule2dViewer', {...
        'id', 'dashbio-default-molecule2d',...
        'modelData', model_data});
    
Hr = Html('Hr');

divHtml = Html('Div', {'id', 'default-molecule2d-output'});
    
components = {componentMolecule, Hr, divHtml};

% Callbacks
args = {...
    argsOut('default-molecule2d-output', 'children'),...
    argsIn('dashbio-default-molecule2d', 'selectedAtomIds')};
handle = 'update_selected_atoms';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);