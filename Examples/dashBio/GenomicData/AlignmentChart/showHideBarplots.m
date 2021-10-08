terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/J2B8A');

component = dashBio('AlignmentChart', {...
        'data', data,...
        'showconservation', false,...
        'showgap', false});   
    
components = {component};

% Run the app
startDash(components, 8057);