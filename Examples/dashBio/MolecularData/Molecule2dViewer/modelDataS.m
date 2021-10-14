terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JV879');
modelData = jsondecode(char(data));

for k=1:numel(modelData.('nodes'))
    modelData.('nodes')(k).('atom') = 'N';
end

for k=1:numel(modelData.('links'))
    modelData.('links')(k).('distance') = 50.0;
    modelData.('links')(k).('strength') = 0.5;
end

component = dashBio('Molecule2dViewer', {...
        'id', 'molecule2d-modeldata',...
        'modelData', modelData});
    
components = {component};

% Run the app
startDash(components, 8057);