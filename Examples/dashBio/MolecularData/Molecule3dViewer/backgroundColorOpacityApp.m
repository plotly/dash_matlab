terminate(pyenv);
clearvars;

% Read data files
modelData = readBioData('https://git.io/JV8hc', 'noutf8');
stylesData  = readBioData('https://git.io/JV4er', 'noutf8');

componentMolecule = dashBio('Molecule3dViewer', {...
        'styles', stylesData,...
        'modelData', modelData,...
        'backgroundColor', '#FF0000',...
        'backgroundOpacity', 0.2});
    
components = {componentMolecule};

% Run the app
startDash(components, 8057);