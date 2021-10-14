terminate(pyenv);
clearvars;

% Read data files
modelData = readBioData('https://git.io/JV8hc', 'noutf8');
stylesData  = readBioData('https://git.io/JV4er', 'noutf8');

componentMolecule = dashBio('Molecule3dViewer', {...
        'styles', stylesData,...
        'modelData', modelData,...
        'selectionType', 'Chain'});
    
components = {componentMolecule};

% Run the app
startDash(components, 8057);