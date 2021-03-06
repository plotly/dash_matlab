terminate(pyenv);
clearvars;

% Read data files
modelData = readBioData('https://git.io/JwhF7', 'noutf8');
stylesData  = readBioData('https://git.io/JwhbH', 'noutf8');
cubeData = readBioData('https://git.io/JwhNn');

componentMolecule = dashBio('Molecule3dViewer', {...
        'styles', stylesData,...
        'modelData', modelData,...
        'selectionType', 'atom',...
        'orbital', struct(...
            'cube_file', cubeData,...
            'iso_val', 0.1,...
            'opacity', 1.0,...
            'positiveVolumetricColor', 'red',...
            'negativeVolumetricColor', 'blue')});
    
components = {componentMolecule};

% Run the app
startDash(components, 8057);