terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVu9Q');
data = py.json.loads(char(data));

component = dashBio('OncoPrint', {...
        'data', data,...
        'showlegend', false,...
        'showoverview', false});   
    
components = {component};

% Run the app
startDash(components, 8057);