terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JV879');
modelData = jsondecode(char(data));

selectedAtoms = {10};
for i=0:9
    selectedAtoms{i+1} = i;
end

component = dashBio('Molecule2dViewer', {...
        'id', 'molecule2d-selectedatomids',...
        'modelData', modelData,...
        'selectedAtomIds', selectedAtoms});
    
components = {component};

% Run the app
startDash(components, 8057);