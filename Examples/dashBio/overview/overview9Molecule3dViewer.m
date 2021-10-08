terminate(pyenv);
clearvars;

% Read data file
model_data = readBioData('https://git.io/JV8hc', 'noutf8');
styles_data  = readBioData('https://git.io/JV4er', 'noutf8');

component = dashBio('Molecule3dViewer', {...
        'id', 'my-dashbio-molecule3dviewer',...
        'modelData', model_data,...
        'styles', styles_data,...
        'backgroundOpacity', '0'});
    
components = {component};

% Run the app
startDash(components, 8057);