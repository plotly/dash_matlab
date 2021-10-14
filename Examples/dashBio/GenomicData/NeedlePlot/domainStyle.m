terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVRcs');
mdata = jsondecode(char(data));

component = dashBio('NeedlePlot', {...
        'mutationData', mdata,...
        'domainStyle', struct(...
            'displayMinorDomains', true,...
            'domainColor', {{'#FFDD00', '#00FFDD', '#0F0F0F', '#D3D3D3'}})});
    
components = {component};

% Run the app
startDash(components, 8057);