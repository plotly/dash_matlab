terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JV879');
model_data = jsondecode(char(data));

component = dashBio('Molecule2dViewer', {...
        'id', 'my-dashbio-molecule2dviewer',...
        'modelData', model_data});
    
components = {component};

% Run the app
startDash(components, 8057);