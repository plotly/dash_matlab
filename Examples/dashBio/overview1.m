terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/J2B8A');

component = dashBio('AlignmentChart', {...
        'id', 'my-dashbio-alignmentchart',...
        'data', data});
    
components = {component};

% Run the app
startDash(components, 8057);