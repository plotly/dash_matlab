terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVRcs');
mdata = jsondecode(char(data));

component = dashBio('NeedlePlot', {...
        'id', 'my-dashbio-nedleplot',...
        'mutationData', mdata});
    
components = {component};

% Run the app
startDash(components, 8057);