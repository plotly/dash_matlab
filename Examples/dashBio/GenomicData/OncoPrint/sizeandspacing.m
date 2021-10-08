terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVu9Q');
data = py.json.loads(char(data));

component = dashBio('OncoPrint', {...
        'data', data,...
        'height', 800,...
        'width', 500,...
        'padding', 0.25});   
    
components = {component};

% Run the app
startDash(components, 8057);