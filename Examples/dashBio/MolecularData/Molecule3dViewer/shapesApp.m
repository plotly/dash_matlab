terminate(pyenv);
clearvars;

% Read data files
modelData = readBioData('https://git.io/JV8hc', 'noutf8');
stylesData  = readBioData('https://git.io/JV4er', 'noutf8');

componentMolecule = dashBio('Molecule3dViewer', {...
        'styles', stylesData,...
        'modelData', modelData,...
        'shapes', {...
            struct(...
                'type', 'Sphere',...
                'center', struct('x', 0, 'y', 0, 'z', 0),...
                'radius', 3.0,...
                'color', 'blue',...
                'opacity', 1),...
            struct(...
                'type', 'Arrow',...
                'start', struct('x', 40, 'y', 20.0, 'z', 0.0),...
                'end', struct('x', 20.0, 'y', 10.0, 'z', 0.0),...
                'radius', 1.0,...
                'radiusRadio', 0.5,...
                'mid', 1.0,...
                'color', 'red',...
                'opacity', 1),...
            struct(...
                'type', 'Cylinder',...
                'start', struct('x', 10.0, 'y', -30.0, 'z', 0.0),...
                'end', struct('x', 20.0, 'y', -50.0, 'z', 0.0),...
                'radius', 1.0,...
                'fromCap', 1,...
                'toCap', 2,...
                'color', 'green',...
                'opacity', 1)}});
    
components = {componentMolecule};

% Run the app
startDash(components, 8057);